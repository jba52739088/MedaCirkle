//
//  MoyaClient.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/22.
//

import Foundation
import Moya
import RxSwift
import Alamofire

public class MoyaClient {
  private let newRestService: MoyaProvider<RestTarget>

  private let dataParsingQueue: DispatchQueue
  private let _errorEmittor: PublishSubject<Error> = PublishSubject()

  private let restConfig: RestTargetConfiguration

  public var errorEmittor: Observable<Error> {
    return _errorEmittor.asObservable()
  }

  public var onReceiveResponse: ((Moya.Response) -> Void)?

  public init(
    configuration: RestTargetConfiguration,
    dataParsingQueue: DispatchQueue,
    userAgent: String
  ) {
    self.dataParsingQueue = dataParsingQueue

    var plugins: [PluginType] = []

    if configuration.enableLogging {
      plugins.append(NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose)))
    }

    // Config url session
    let sessionConfiguration = URLSessionConfiguration.default
    sessionConfiguration.httpAdditionalHeaders = HTTPHeaders.default.dictionary
    sessionConfiguration.httpCookieStorage = nil
    sessionConfiguration.httpShouldSetCookies = false
    sessionConfiguration.urlCache = nil

    // Setup session manager
    let session = Session(
      configuration: sessionConfiguration,
      startRequestsImmediately: false,
      serverTrustManager: ServerTrustManager(
        allHostsMustBeEvaluated: false,
        evaluators: [:]
      )
    )

    restConfig = configuration

    self.newRestService = MoyaProvider<RestTarget>(
      endpointClosure: { target -> Endpoint in
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
        return defaultEndpoint.adding(newHTTPHeaderFields: ["User-Agent": userAgent])
      },
      callbackQueue: dataParsingQueue,
      session: session,
      plugins: plugins
    )
  }
}

// MARK: - New vesion after refactoring
extension MoyaClient {
  public func send<RequestType: DeserializableRequestType>(request: RequestType)
    -> Observable<RequestType.ResponseType> {
    let target = RestTarget(configuration: restConfig, request: request)
    let observable = newRestService.rx.request(target).asObservable()
      .do(
        onNext: { [weak self] response in
          guard let self = self else { return }
          self.onReceiveResponse?(response)
        },
        onError: { [weak self] error in
          guard let self = self else { return }
          self._errorEmittor.onNext(error)
        }
      )
      .map({ try request.map(response: $0) })

    return observable
  }
}

