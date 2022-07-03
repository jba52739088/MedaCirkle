//
//  SceneTransition.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/25.
//

import Foundation
import UIKit

internal enum SceneTransition {
  // New scene as the root of the window
  case root(shouldDismissPresented: (all: Bool, animated: Bool?))

  // Normal present
  case present(transitionStyle: UIModalTransitionStyle? = nil, animated: Bool = true)

  // custom modal presentation
  case customModal(
    transition: UIViewControllerTransitioningDelegate? = nil,
    presentationStyle: UIModalPresentationStyle,
    animated: Bool = true
  )

  case push(animated: Bool)

  case share

  // The system chooses an appropriate animation style for you
  case automatic
}

enum SceneTransitionOption {
  // Wrap the view controller with a navigation controller
  case wrapWithNavigationController(UINavigationController.Type)
}

extension SceneTransition {
  static let overFullScreen = SceneTransition.customModal(transition: nil, presentationStyle: .overFullScreen, animated: false)
  static let root = SceneTransition.root(shouldDismissPresented: (true, false))
}

extension SceneTransition {
  enum RootShouldDismissAllPresented {
    case none
    case `false`
    case `true`(animated: Bool)
    case all(animated: Bool)
    case animated
    case notAnimated
  }
}

