//
//  EnvironmentConfiguration.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/22.
//

import Foundation

public protocol MoyaConfiguration {
  var restAPIUrl: URL { get }
}


public struct EnvironmentConfiguration {
  private struct Keys {
    static let prod = "prod"
    static let debug = "debug"
  }

  public var restAPIEndpoint: String
}

// MARK: - Helper

public extension EnvironmentConfiguration {
  static let debug = EnvironmentConfiguration(
    restAPIEndpoint: "https://s.muds.me/social"
  )

  static let prod = EnvironmentConfiguration(
    restAPIEndpoint: "https://s.muds.me/social"
  )

  init?(string: String) {
    if string == Keys.prod {
      self = .prod
    } else {
      self = .debug
    }
  }
}

// MARK: - Equatable

extension EnvironmentConfiguration: Equatable {}

// MARK: - CustomStringConvertible

extension EnvironmentConfiguration: CustomStringConvertible {
  public var description: String {
    if self == .prod {
      return Keys.prod
    } else {
      return Keys.debug
    }
  }
}

// MARK: - CustomDebugStringConvertible

extension EnvironmentConfiguration: CustomDebugStringConvertible {
  public var debugDescription: String {
    return """
    restAPIEndpoint: \(self.restAPIEndpoint)
    """
  }
}

// MARK: - MoyaConfiguration

extension EnvironmentConfiguration: MoyaConfiguration {
  public var restAPIUrl: URL {
    return URL(string: self.restAPIEndpoint)!
  }
}
