//
//  RegisterRequest.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/22.
//

import Moya

public struct RegisterRequest: DeserializableRequestType {
  public init(token: String, name: String, gender: String, birthday: String) {
    self.token = token
    self.name = name
    self.gender = gender
    self.birthday = birthday
  }

  public let token: String
  public let name: String
  public let gender: String
  public let birthday: String

  public func accept<VisitorType: RestRequestVisitorType>(visitor: VisitorType)
    -> VisitorType.ResultType {
    return visitor.forRegister(self)
  }

  public func map(response: Response) throws -> LoginResponse? {
    try response.map(LoginResponse.self)
  }
}

