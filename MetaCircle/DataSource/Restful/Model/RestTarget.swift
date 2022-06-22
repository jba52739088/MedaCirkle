//
//  RestTarget.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/22.
//

import Moya

public struct RestTarget {
  public let configuration: RestTargetConfiguration
  public let request: RestRequestType

  let urlVisitor: RequestURLVisitor
  let pathVisitor: RequestPathVisitor
  let methodVisitor: RequestMethodVisitor
  let taskVisitor: RequestTaskVisitor
  let headerVisitor: RequestHeaderVisitor

  public init(configuration: RestTargetConfiguration, request: RestRequestType) {
    self.configuration = configuration
    self.request = request

    urlVisitor = RequestURLVisitor(configuration: configuration)
    pathVisitor = RequestPathVisitor(configuration: configuration)
    methodVisitor = RequestMethodVisitor()
    taskVisitor = RequestTaskVisitor(configuration: configuration)
    headerVisitor = RequestHeaderVisitor(configuration: configuration)
  }

  // MARK: -

//  var authenticationCredential: URLCredential? { request.accept(visitor: authenticationVisitor) }
}

// MARK: - TargetType

extension RestTarget: TargetType {
  public var baseURL: URL { request.accept(visitor: urlVisitor) }

  public var path: String { request.accept(visitor: pathVisitor) }

  public var method: Moya.Method { request.accept(visitor: methodVisitor) }

  public var sampleData: Data { Data() }

  public var task: Task { request.accept(visitor: taskVisitor) }

  public var headers: [String: String]? { request.accept(visitor: headerVisitor) }
}
