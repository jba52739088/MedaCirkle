//
//  RestTargetConfiguration.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/22.
//

import Foundation

public enum RestConstants {

  static var devEnvironmentAPIEndpointHostSubdomain: String {
    #if DEBUG
    return ""
    #else
    return ""
    #endif
  }
}

public struct RestTargetConfiguration {
  public let restAPIUrl: URL
  public let enableLogging: Bool

  // Rest
  public let apiPrefix = "/api"

}
