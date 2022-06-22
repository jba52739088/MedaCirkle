//
//  APIClient.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/22.
//

import Foundation
import Moya
import RxSwift
import DeviceKit

public class APIClient {
  private let moyaClient: MoyaClient
  private let userSessionManager: UserSessionManager


  public static var userAgent: String = {
    // e.g. Newspulse/4.0.3(28) (iOS 10.2.1; iPad (6th generation))
    return "MetaCircle/\(Globals.appVersionString)(\(Globals.buildNumberString)) (\(UIDevice.current.systemName) \(UIDevice.current.systemVersion); \(Device.current.safeDescription))"
  }()

  private let dataParsingQueue = DispatchQueue(label: "com.metacircle.dataparsing",
                                               qos: DispatchQoS.utility)


  public init(configuration: MoyaConfiguration, userSessionManager: UserSessionManager) {

    #if DEBUG
    let enableLogging = true
    #else
    let enableLogging = false
    #endif

    let restConfig = RestTargetConfiguration(
      restAPIUrl: configuration.restAPIUrl,
      enableLogging: enableLogging
    )

    moyaClient = MoyaClient(
      configuration: restConfig,
      dataParsingQueue: dataParsingQueue,
      userAgent: APIClient.userAgent
    )

    self.userSessionManager = userSessionManager

    moyaClient.onReceiveResponse = { [weak self] response in
      // Check if session tokens are refreshed
      guard let this = self else { return }
//      this.fetchServerDate(from: response.response)
    }
  }


  public func send<RequestType: DeserializableRequestType>(request: RequestType)
    -> Observable<RequestType.ResponseType> {
    return moyaClient.send(request: request)
  }
}

