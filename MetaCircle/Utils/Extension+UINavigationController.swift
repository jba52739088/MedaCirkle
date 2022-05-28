//
//  Extension+UINavigationController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/26.
//

import Foundation
import UIKit

extension UINavigationController {

  public func pushViewController(
    viewController: UIViewController,
    animated: Bool,
    completion: @escaping () -> Void) {
    pushViewController(viewController, animated: animated)

    guard animated, let coordinator = transitionCoordinator else {
      DispatchQueue.main.async { completion() }
      return
    }

    coordinator.animate(alongsideTransition: nil) { _ in completion() }
  }

  func popViewController(
    animated: Bool,
    completion: @escaping () -> Void) {
    popViewController(animated: animated)

    guard animated, let coordinator = transitionCoordinator else {
      DispatchQueue.main.async { completion() }
      return
    }

    coordinator.animate(alongsideTransition: nil) { _ in completion() }
  }
}
