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
    case .home, .leading:
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
    case .leading:
      return IntroViewController()
    case .chooseTopic:
      return TopicViewController()
    case let .chooseTopicFeature(vm):
      return TopicFeatureViewController(vm)
    case .forgetPassword:
      return ForgetPwdViewController(ForgetPwdViewModel())
    case .resetPassword:
      return ResetPwdViewController()
    case let .verify(vm):
      return VerifyViewController(vm)
    case .createCircle:
      return CircleCreateViewController()
    case .circleCreateProfile:
      return CircleCreateProfileViewController()
    case .login:
      return LoginViewController()
    case .register:
      return RegisterViewController()
    case let .circleContent(vm):
      return  CircleContentViewController(vm)
    case let .circle(vm):
      return CircleViewController()
    case let .memberProfile(vm):
      return ProfileViewController(vm)
    case .editProfile:
      return EditProfileViewController()
    case .editWebsite:
      return EditWebSiteViewController()
    }
  }
}
