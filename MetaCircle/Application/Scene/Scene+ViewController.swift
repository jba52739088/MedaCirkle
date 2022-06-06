//
//  Scene+ViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/26.
//

import Foundation
import UIKit

extension Scene {
  var defaultTransitionOptions: [SceneTransitionOption] {
    switch self {
    case .home, .welcome:
      return [.wrapWithNavigationController(NavigationController.self)]
    default:
      return []
    }
  }

  func viewController() -> UIViewController {
    return private_viewController()
  }

  private var isPad: Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
  }

  private func private_viewController() -> UIViewController {
    switch self {
    case .home:
      return MainViewController()
    case .welcome:
      return IntroViewController()
    case .forgetPassword:
      return ForgetPwdViewController(ForgetPwdViewModel())
    case .resetPassword:
      return ResetPwdViewController()
    case .createCircle:
      return CircleCreateViewController()
    }
  }
}
