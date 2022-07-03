//
//  RegisterSendSMSRequest.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/22.
//

import Moya

public struct RegisterSendSMSRequest: DeserializableRequestType {
  public init(token: String, mobile: String) {
    self.token = token
    self.mobile = mobile
  }

  public let token: String
  public let mobile: String

  public func accept<VisitorType: RestRequestVisitorType>(visitor: VisitorType)
    -> VisitorType.ResultType {
    return visitor.forRegisterSendSMS(self)
  }

  public func map(response: Response) throws -> LoginResponse? {
    try response.map(LoginResponse.self)
  }
}


