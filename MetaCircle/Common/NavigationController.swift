//
//  NavigationController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/26.
//

import Foundation
import RxSwift
import UIKit

internal class NavigationController: UINavigationController {
  private var popRecognizer: InteractivePopRecognizer?
  internal let disposeBag = DisposeBag()

  override var childForStatusBarStyle: UIViewController? {
    return topViewController
  }

  internal override func viewDidLoad() {
    super.viewDidLoad()

    isNavigationBarHidden = true
    popRecognizer = InteractivePopRecognizer(navigationController: self)
    interactivePopGestureRecognizer?.delegate = popRecognizer
    self.delegate = popRecognizer
  }

  override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    popRecognizer?.disabled = true
    super.pushViewController(viewController, animated: animated)
  }
}

internal class InteractivePopRecognizer: NSObject, UIGestureRecognizerDelegate, UINavigationControllerDelegate {
  internal weak var navigationController: UINavigationController?
  fileprivate var disabled: Bool = true

  internal init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  private func update() {
    let childCount = navigationController?.viewControllers.count ?? 0
    disabled = childCount <= 1
  }

  internal func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    if gestureRecognizer == navigationController?.interactivePopGestureRecognizer && disabled {
      return false
    }
    return true
  }

  func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    update()
  }

  internal func gestureRecognizer(
    _ gestureRecognizer: UIGestureRecognizer,
    shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)
    -> Bool {
    return false
  }
}
