//
//  MainAppService.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/26.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

public protocol ApplicationService: UIApplicationDelegate {}

class MainAppService: NSObject, ApplicationService {

  static let shared = MainAppService()

  let userSessionRequestManager = UserSessionRequestManager(userSessionManager: UserSessionManager.shared)
  let preferenceManager = PreferenceManager(dataSource: UserDefaultsStore.shared)
  private let isSetupCompletedRelay = BehaviorRelay<Bool>(value: false)

  var isSetupCompleted: Bool {
    get { isSetupCompletedRelay.value }
    set { isSetupCompletedRelay.accept(newValue) }
  }
}
