//
//  EnvironmentManager.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/22.
//

import Foundation
import RxSwift
import RxCocoa

func dataLoader() -> APIClient {
  return EnvironmentManager.current.client
}

public class EnvironmentManager {

  private struct Keys {
    static let kUserEnvConfig: String = "userEnvConfig"
  }

  public static let current = EnvironmentManager()

  private let configurationRelay: BehaviorRelay<EnvironmentConfiguration>
  private let userSessionManager: UserSessionManager = UserSessionManager.shared
  private let disposeBag = DisposeBag()

  private(set) var client: APIClient

  init(configuration: EnvironmentConfiguration) {
    configurationRelay = BehaviorRelay<EnvironmentConfiguration>(value: configuration)

    client = APIClient(configuration: configuration, userSessionManager: userSessionManager)

    #if DEBUG
    configurationRelay
      .subscribe(onNext: { [weak self] configuration in
        guard let self = self else { return }
        self.client = APIClient(configuration: configuration, userSessionManager: self.userSessionManager)
      })
      .disposed(by: disposeBag)
    #endif
  }

  #if DEBUG
  public func changeTo(newConfig: EnvironmentConfiguration) {
//    logger.debug("[Env] Attempting to change environment to: \(newConfig)")

    UserDefaults.standard.set(newConfig.description, forKey: Keys.kUserEnvConfig)
    configurationRelay.accept(newConfig)
//    logger.debug("[Env] Current Environment Manager Config: \(newConfig)")
  }
  #endif
}

// MARK: - Helper

extension EnvironmentManager {
  private static func loadConfigurationFromUserDefaults() -> EnvironmentConfiguration {
//    logger.debug("[Env] Grabbing User Env Config")
    #if DEBUG
    if let configStr = UserDefaults.standard.value(forKey: Keys.kUserEnvConfig) as? String,
      let config = EnvironmentConfiguration(string: configStr) {
      return config
    }

    // TODO: reverse the environment back to prod later
    //let defaultEnv = EnvironmentConfiguration.prod
    let defaultEnv = EnvironmentConfiguration.debug
//    UserDefaults.standard.set(defaultEnv.description, forKey: Keys.kUserEnvConfig)
//    logger.debug("[Env] User Env Config is: prod)")
    return .debug
    #else
      return .prod
    #endif
  }

  private convenience init() {
    let config = EnvironmentManager.loadConfigurationFromUserDefaults()
    self.init(configuration: config)
  }

  var configuration: EnvironmentConfiguration {
    return configurationRelay.value
  }

  var configurationObservable: Observable<EnvironmentConfiguration> {
    return configurationRelay.asObservable()
  }
}
