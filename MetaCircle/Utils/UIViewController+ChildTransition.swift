//
//  UIViewController+ChildTransition.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/26.
//

import UIKit

// MARK: Transit between child view controllers
extension UIViewController {
  /// animte children with transitionCrossDissolve as default animation
  func replaceChild(_ oldChild: UIViewController?,
                    with newChild: UIViewController?,
                    completion: VoidBlock? = nil) {

    let duration: TimeInterval
    let options: UIView.AnimationOptions

    if viewIfLoaded?.window == nil || oldChild == nil {
      duration = 0
      options = []
    } else {
      duration = 0.25
      options = .transitionCrossDissolve
    }

    switch (oldChild, newChild) {
    case let (o?, n?):
      transition(from: o, to: n, in: view, duration: duration, options: options, completion: completion)
    case (nil, let n?):
      transition(to: n, in: view, duration: duration, options: options, completion: completion)
    case (let o?, nil):
      transition(from: o, in: view, duration: duration, options: options, completion: completion)
    case (nil, nil):
      completion?()
      return
    }

  }

  private func transition(to: UIViewController, in container: UIView, duration: TimeInterval, options: UIView.AnimationOptions, completion: VoidBlock?) {

    // embed the "to" view
    // animate it in

    to.beginAppearanceTransition(true, animated: true)
    addChild(to)
    to.view.alpha = 0
    container.embedSubview(to.view)

    UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
      to.view.alpha = 1
    }, completion: { _ in
      to.didMove(toParent: self)
      to.endAppearanceTransition()
      completion?()
    })
  }

  private func transition(from: UIViewController, in container: UIView, duration: TimeInterval, options: UIView.AnimationOptions, completion: VoidBlock?) {

    // animate out the "from" view
    // remove it

    from.beginAppearanceTransition(false, animated: true)
    from.willMove(toParent: nil)
    UIView.animate(withDuration: duration, animations: {
      from.view.alpha = 0
    }, completion: { _ in
      from.view.removeFromSuperview()
      from.endAppearanceTransition()
      from.removeFromParent()
      completion?()
    })
  }

  private func transition(from: UIViewController, to: UIViewController, in container: UIView, duration: TimeInterval, options: UIView.AnimationOptions, completion: VoidBlock?) {

    if from == to { return }

    // animate from "from" view to "to" view

    from.beginAppearanceTransition(false, animated: true)
    to.beginAppearanceTransition(true, animated: true)

    from.willMove(toParent: nil)
    addChild(to)

    to.view.alpha = 0
    from.view.alpha = 1

    container.embedSubview(to.view)
    container.bringSubviewToFront(from.view)

    UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
      to.view.alpha = 1
      from.view.alpha = 0
    }, completion: { _ in

      from.view.removeFromSuperview()

      from.endAppearanceTransition()
      to.endAppearanceTransition()

      from.removeFromParent()
      to.didMove(toParent: self)
      completion?()
    })

  }

}
