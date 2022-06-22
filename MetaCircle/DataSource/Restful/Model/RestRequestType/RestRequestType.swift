//
//  RestRequestType.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/22.
//

import Foundation
import Moya

public protocol RestRequestType {
  func accept<VisitorType: RestRequestVisitorType>(visitor: VisitorType)
    -> VisitorType.ResultType
}

public protocol MoyaResponseDeserializable {
  associatedtype ResponseType

  func map(response: Moya.Response) throws -> ResponseType
}

public typealias DeserializableRequestType = MoyaResponseDeserializable & RestRequestType
