//
//  LogoutRequest.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/3.
//

import Moya

public struct LogoutRequest: DeserializableRequestType {
  public init() { }


  public func accept<VisitorType: RestRequestVisitorType>(visitor: VisitorType)
    -> VisitorType.ResultType {
    return visitor.forLogout(self)
  }

  public func map(response: Response) throws -> LoginResponse? {
    try response.map(LoginResponse.self)
  }
}



