//
//  RegisterSendMailRequest.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/22.
//

import Moya

public struct RegisterSendMailRequest: DeserializableRequestType {
  public init(mail: String, password: String) {
    self.mail = mail
    self.password = password
  }

  public let mail: String
  public let password: String

  public func accept<VisitorType: RestRequestVisitorType>(visitor: VisitorType)
    -> VisitorType.ResultType {
    return visitor.forRegisterSendMail(self)
  }

  public func map(response: Response) throws -> RegisterResponse? {
    try response.map(RegisterResponse.self)
  }
}
