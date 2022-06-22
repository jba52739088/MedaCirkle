//
//  RegisterVerifyMailRequest.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/22.
//

import Moya

public struct RegisterVerifyMailRequest: DeserializableRequestType {
  public init(token: String, code: String) {
    self.token = token
    self.code = code
  }

  public let token: String
  public let code: String

  public func accept<VisitorType: RestRequestVisitorType>(visitor: VisitorType)
    -> VisitorType.ResultType {
    return visitor.forRegisterVerifyMail(self)
  }

  public func map(response: Response) throws -> RegisterResponse? {
    try response.map(RegisterResponse.self)
  }
}

