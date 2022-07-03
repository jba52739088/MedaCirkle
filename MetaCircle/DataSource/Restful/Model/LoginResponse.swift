//
//  LoginResponse.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/1.
//

import Foundation

// MARK: - RegisterResponse
public struct LoginResponse: Decodable {
  public var success: Bool?
  public var token, cooldown, type, error: String?
  public var message: String?
  public var errors: [Error]?

  // MARK: - Error
  public struct Error: Decodable {
    public var name, message, type: String?
  }
}
