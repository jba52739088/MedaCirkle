//
//  RegisterReSendMailRequest.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/22.
//

import Moya

public struct RegisterReSendMailRequest: DeserializableRequestType {
  public init(token: String) {
    self.token = token
  }

  public let token: String

  public func accept<VisitorType: RestRequestVisitorType>(visitor: VisitorType)
    -> VisitorType.ResultType {
    return visitor.forRegisterReSendMail(self)
  }

  public func map(response: Response) throws -> RegisterResponse? {
    try response.map(RegisterResponse.self)
  }
}
