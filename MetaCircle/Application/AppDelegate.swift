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
  var didShowInrto: Bool = false

  // MARK: - Services
  let mainAppService = MainAppService.shared

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    UITabBar.appearance().backgroundColor = .normalLightBg
    UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 10)
    UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.tappableText,
                                                      .font: R.font.notoSansTCRegular(size: 10) as Any],
                                                     for: .selected)
    UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.categoryTextGray,
                                                      .font: R.font.notoSansTCRegular(size: 10) as Any],
                                                     for: .normal)

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
