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

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    UITabBar.appearance().backgroundColor = .white
    IQKeyboardManager.shared.enable = true

    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window?.rootViewController = MainViewController()
    self.window?.makeKeyAndVisible()
    return true
  }

  func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.portrait
  }
}

