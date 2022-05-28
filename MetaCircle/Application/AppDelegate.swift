//
//  AppDelegate.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/14.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  static var shared: AppDelegate! {
    return UIApplication.shared.delegate as! AppDelegate
  }
  
  var window: UIWindow?

  private(set) var sceneCoordinator: SceneCoordinator!

  // MARK: - Services
  let mainAppService = MainAppService.shared

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    UITabBar.appearance().backgroundColor = .white
    IQKeyboardManager.shared.enable = true


    sceneCoordinator = PhoneSceneCoordinator()

    sceneCoordinator.launchInitialScene { [weak self] in
      guard let self = self else { return }
      self.finishSetup()
    }

//    self.window = sceneCoordinator.window
//    self.window?.rootViewController = MainViewController()
//    self.window?.makeKeyAndVisible()
    return true
  }

  func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.portrait
  }
}

// TODO: temporarily make finishSetup for iPad. Later the state should not maintained in AppDelegate
extension AppDelegate {
  func finishSetup() {
    mainAppService.isSetupCompleted = true
  }
}
