//
//  LoginRequest.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/1.
//

import Moya

public struct LoginRequest: DeserializableRequestType {
  public init(mail: String, password: String) {
    self.mail = mail
    self.password = password
  }

  public let mail: String
  public let password: String

  public func accept<VisitorType: RestRequestVisitorType>(visitor: VisitorType)
    -> VisitorType.ResultType {
    return visitor.forLogin(self)
  }

  public func map(response: Response) throws -> LoginResponse? {
    try response.map(LoginResponse.self)
  }
}


