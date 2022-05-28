//
//  SceneCoordinator.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/25.
//

import Foundation
import RxSwift
import UIKit

internal protocol SceneCoordinator {
  var window: UIWindow { get }

  func transit(to scene: Scene,
               by transition: SceneTransition,
               completion: (() -> Void)?)
  func transit(to scene: Scene,
               by transition: SceneTransition,
               options: [SceneTransitionOption],
               completion: (() -> Void)?)

  // Dismiss current active scene
  func dismiss(animated: Bool, completion: (() -> Void)?)

  /* If you must dismiss a view controller without using the SC, then call this
   method to recalibrate the currentViewController reference */
  func recalibrate()

  var currentViewController: UIViewController? { get set }
  var currentViewControllerObs: Observable<UIViewController?> { get }

  func launchInitialScene(by transition: SceneTransition, withCompletion: (() -> Void)?)

  /// Find the view controllers of certain type in current window hierarchy. Topmost view controller comes first
  func findViewControllers<T>(of class: T.Type) -> [T] where T: UIViewController
}

extension SceneCoordinator {
  /// Find the view controllers of certain type in current window hierarchy. Topmost view controller comes first
  func findViewControllers<T>(of class: T.Type) -> [T] where T: UIViewController {
    var vcs: [T] = []
    var vc = window.rootViewController

    while let currentVC = vc {
      if let currentVC = currentVC as? T {
        vcs.insert(currentVC, at: 0)
      }

      for child in currentVC.children {
        if let child = child as? T {
          vcs.insert(child, at: 0)
        }
      }

      vc = currentVC.presentedViewController
    }

    return vcs
  }
}

extension SceneCoordinator {
  internal func launchInitialScene(by transition: SceneTransition = .root, withCompletion completion: (() -> Void)?) {
    switch self {
    case _ as PhoneSceneCoordinator: launchInitialScene(by: transition, withCompletion: completion)
    default: return
    }
  }
}
