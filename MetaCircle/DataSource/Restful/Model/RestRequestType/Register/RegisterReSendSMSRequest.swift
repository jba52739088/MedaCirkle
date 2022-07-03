//
//  RegisterReSendSMSRequest.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/22.
//

import Moya

public struct RegisterReSendSMSRequest: DeserializableRequestType {
  public init(token: String) {
    self.token = token
  }

  public let token: String

  public func accept<VisitorType: RestRequestVisitorType>(visitor: VisitorType)
    -> VisitorType.ResultType {
    return visitor.forRegisterReSendSMS(self)
  }

  public func map(response: Response) throws -> LoginResponse? {
    try response.map(LoginResponse.self)
  }
}

