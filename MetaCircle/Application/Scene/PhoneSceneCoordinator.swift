//
//  PhoneSceneCoordinator.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/25.
//

import Foundation
import RxSwift
import UIKit

internal class PhoneSceneCoordinator: SceneCoordinator {
  var welcomePageDone: Bool {
    get { return AppDelegate.shared.mainAppService.preferenceManager.welcomePageDone }
    set { AppDelegate.shared.mainAppService.preferenceManager.welcomePageDone = newValue }
  }

  internal static let shared: SceneCoordinator = PhoneSceneCoordinator()

  internal var window: UIWindow

  internal weak var currentViewController: UIViewController? {
    didSet {
      currentViewControllerPublishSubject.onNext(currentViewController)
    }
  }
  fileprivate let transitionQueue = DispatchQueue(label: "com.scmp.coordinator.transition")
  fileprivate let transitionSemaphore = DispatchSemaphore(value: 1)

  internal var currentViewControllerObs: Observable<UIViewController?>
  private let currentViewControllerPublishSubject = PublishSubject<UIViewController?>()
  private let disposeBag = DisposeBag()

  private var rootViewController: PhoneRootViewController!

  private var interstitialFailureBlock: VoidBlock?
  private var interstitailDismissalBlock: VoidBlock?

  init() {
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.currentViewControllerObs = currentViewControllerPublishSubject.asObservable()
  }

  private var deferredInitialAction: (() -> Void)?
  private var sceneInTransition: Scene?

  internal func launchInitialScene(by transition: SceneTransition = .root, withCompletion completion: (() -> Void)?) {
    if rootViewController == nil {
      rootViewController = PhoneRootViewController(splashDidDisappear: nil)
      window.rootViewController = rootViewController
      rootViewController.loadViewIfNeeded()
      window.makeKeyAndVisible()
    }

    transitToInitialScene(by: transition, completion: completion)
  }

  // Transit to content after interstitial
  private func transitToInitialScene(by transition: SceneTransition = .root, completion: VoidBlock?) {
    let initialScene: Scene = shouldShowWelcomePageOnboarding ? .welcome : .home
    if shouldShowWelcomePageOnboarding {
      deferredInitialAction = { [weak self] in self?.deferredInitialAction?(); completion?(); } // FIXIT
      transit(to: initialScene, by: transition, completion: nil)
    } else if let deferredInitialAction = deferredInitialAction {
      transit(to: initialScene, by: transition, completion: { deferredInitialAction(); completion?() }) // FIXIT
      self.deferredInitialAction = nil
    } else {
      transit(to: initialScene, by: transition, completion: completion)
    }
  }

  // MARK: Presentation / Transitting

  internal func transit(to scene: Scene, by transition: SceneTransition = .automatic, completion: (() -> Void)?) {
    transit(to: scene, by: transition, options: scene.defaultTransitionOptions, completion: completion)
  }
  internal func transit(to scene: Scene, by transition: SceneTransition = .automatic, options: [SceneTransitionOption] = [], completion: (() -> Void)?) {
    var scene = scene
    // Not to transit to the same scene again
    guard sceneInTransition != scene else {
      completion?()
      return
    }

    recalibrate()

    transitionQueue.async {
      self.transitionSemaphore.wait()

      // Save the initial scene rather than the replaced scene, as comparing initial scene is enough to guard excess transition
      self.sceneInTransition = scene

      DispatchQueue.main.async {
        self.transitWithSceneReplacement(to: scene, by: transition, options: options, completion: {
          self.sceneInTransition = nil
          self.transitionSemaphore.signal()
          completion?()
        })
      }
    }
  }

  private func _replaceSceneWithCheckPath(scene: Scene, transition: SceneTransition) -> Observable<(Scene, SceneTransition)> {

    return .just((scene, transition))
  }

  private func transitWithSceneReplacement(to _scene: Scene, by _transition: SceneTransition, options: [SceneTransitionOption], completion: @escaping (() -> Void)) {
    _replaceSceneWithCheckPath(scene: _scene, transition: _transition)
      .takeLast(1)
      .asSingle()
      .observe(on: MainScheduler.instance)
      .subscribe(onSuccess: { [weak self] scene, transition in
        guard let self = self else {
          completion()
          return
        }
        self._transit(to: scene, by: transition, options: options, completion: completion)
      }, onFailure: { [weak self] _ in
        guard let self = self else {
          completion()
          return
        }

        // Run transit with original scene and transition
        self._transit(to: _scene, by: _transition, options: options, completion: completion)
      })
      .disposed(by: disposeBag)
  }

  private func _transit(to scene: Scene, by transition: SceneTransition, options: [SceneTransitionOption], completion: @escaping (() -> Void)) {
    var viewController = scene.viewController()


    // Wrap the vc with UINavigationController if needed
    options.forEach({ option in
      switch option {
      case .wrapWithNavigationController(let navClass):
        if !(viewController is UINavigationController) {
          let nav = navClass.init(rootViewController: viewController)
          viewController = nav
        }
      }
    })

    switch transition {
    case let .root(shouldDismissPresented):
      _rootTransit(to: viewController, shouldDismissPresented: shouldDismissPresented, completion: completion)
    case let .customModal(transitionDelegate, presentationStyle, animated):
      _modalTransition(
        to: viewController,
        transitioningDelegate: transitionDelegate,
        presentationStyle: presentationStyle,
        animated: animated,
        completion: completion
      )
    case let .present(transitionStyle, animated):
      _presentTransition(to: viewController, transitionStyle: transitionStyle, animated: animated, completion: completion)
    case .push(let animated):
      _pushTransition(to: viewController, animated: animated, completion: completion)
    case .share:
      currentViewController?.present(scene.viewController(),
                                          animated: true,
                                          completion: completion)
    case .automatic:
      _pushTransition(to: viewController, animated: true, completion: completion)
    }
  }

  private func _rootTransit(to viewController: UIViewController, shouldDismissPresented: (all: Bool, animated: Bool?) = (true, true), completion: @escaping (() -> Void)) {
    if let currentRootViewController = rootViewController.content {
      if let (all, animated) = Optional(shouldDismissPresented), all {
        currentRootViewController.dismissAllPresented(animated: animated ?? true, completion: {
          self.currentViewController = PhoneSceneCoordinator.activeViewController(for: viewController)
          self.rootViewController.replaceContentViewController(viewController, completion: completion)
        })
      } else {
        self.currentViewController = PhoneSceneCoordinator.activeViewController(for: viewController)
        self.rootViewController.replaceContentViewController(viewController, completion: completion)
      }


    } else {
      currentViewController = PhoneSceneCoordinator.activeViewController(for: viewController)
      rootViewController.replaceContentViewController(viewController, completion: completion)
    }
  }

  private func _modalTransition(
    to viewController: UIViewController,
    transitioningDelegate: UIViewControllerTransitioningDelegate?,
    presentationStyle: UIModalPresentationStyle = .fullScreen,
    animated: Bool = true,
    completion: @escaping (() -> Void)
  ) {
    viewController.modalPresentationStyle = presentationStyle
    viewController.transitioningDelegate = transitioningDelegate
    viewController.modalPresentationCapturesStatusBarAppearance = true

    if let cur = currentViewController, cur.presentedViewController == nil {
      cur.present(viewController, animated: animated, completion: {
        self.currentViewController = PhoneSceneCoordinator.activeViewController(for: viewController)
        completion()
      })
    } else {
      completion()
    }
  }

  private func _presentTransition(to viewController: UIViewController,
                                  transitionStyle: UIModalTransitionStyle?,
                                  animated: Bool,
                                  completion: @escaping (() -> Void)) {
    if #available(iOS 13.0, *) {
      if viewController.modalPresentationStyle == .pageSheet {
        viewController.modalPresentationStyle = .fullScreen
      }
    }
    if let transitionStyle = transitionStyle {
      viewController.modalTransitionStyle = transitionStyle
    }

    // Current view controller is lost if a presented SFSafariViewController is dismissed
    recalibrate()

    completion()
  }

  private func _pushTransition(to viewController: UIViewController, animated: Bool, completion: @escaping (() -> Void)) {
    func push(to navigationController: UINavigationController) {
      navigationController.pushViewController(viewController: viewController, animated: animated) { [weak self] in
        self?.currentViewController = PhoneSceneCoordinator.activeViewController(for: viewController)
        completion()
      }
    }

    if let cur = currentViewController {
      if let nav = cur as? UINavigationController ?? cur.navigationController {
      push(to: nav)
    }  else {
        completion()
      }
    }
  }

  // MARK: Dismissing

  internal func dismiss(animated: Bool, completion: (() -> Void)?) {
    recalibrate()

    transitionQueue.async {
      self.transitionSemaphore.wait()
      DispatchQueue.main.async {
        self._dismiss(animated: animated, completion: {
          self.transitionSemaphore.signal()
          completion?()
        })
      }
    }
  }

  private func _dismiss(animated: Bool, completion: @escaping (() -> Void)) {
    // Pause any video content when dismissing a given view
    //    resetCurrentViewController()
    recalibrate()

    if let currentVC = currentViewController {
      if let navVC = currentVC.navigationController {
        if navVC.viewControllers[safe: 0] === currentVC {
          navVC.dismiss(animated: animated) {
            //            self.currentViewController = nil
            //            self.recalibrate()
            //            if let resetVC = self.currentViewController {

            //            }
            completion()
          }
        } else {
          navVC.popViewController(animated: animated) {
            self.currentViewController = navVC.topViewController
            completion()
          }
        }
      } else {
        currentVC.dismiss(animated: animated, completion: {
          self.currentViewController = nil
          self.recalibrate()
          if let resetVC = self.currentViewController {
            self.currentViewController = PhoneSceneCoordinator.activeViewController(for: resetVC)
          }

          completion()
        })
      }
    } else if let presentedVC = currentViewController?.presentedViewController {
      if let nav = presentedVC.navigationController {
        nav.popViewController(animated: animated) {
          completion()
        }
      } else {
        presentedVC.dismiss(animated: animated, completion: {
          completion()
        })
      }
    } else if let presenter = currentViewController?.presentingViewController {

      if let cur = currentViewController {
        if let nav = cur.navigationController {
          nav.popViewController(animated: animated) {
            self.currentViewController = PhoneSceneCoordinator.activeViewController(for: presenter)
            completion()
          }
        } else {
          cur.dismiss(animated: animated) {
            self.currentViewController = PhoneSceneCoordinator.activeViewController(for: presenter)
            completion()
          }
        }
      } else {
        completion()
      }
    } else {
      // default handling
      completion()
    }
  }

  // MARK: Utils

  // Get current active view controller for some container view controllers
  internal static func activeViewController(for viewController: UIViewController) -> UIViewController {
    if let nav = viewController as? UINavigationController {
      return nav.topViewController!
    } else {
      return viewController
    }
  }

  internal func recalibrate() {
    var cur = rootViewController.content
    while let pre = cur?.presentedViewController {
      cur = pre
    }
    if let navigationController = cur as? NavigationController {
      currentViewController = navigationController.topViewController
    } else {
      currentViewController = cur
    }
  }
}

extension UIViewController {
  func dismissAllPresented(animated: Bool, completion: (() -> Void)? = nil) {

    if let presented = self.presentedViewController {
      presented.dismissAllPresented(animated: animated) {
        self.dismiss(animated: animated, completion: completion)
      }
    } else {
      completion?()
    }
  }
}

extension PhoneSceneCoordinator {

  var shouldShowWelcomePageOnboarding: Bool {
    get { AppDelegate.shared.mainAppService.preferenceManager.welcomePageDone }
    set { AppDelegate.shared.mainAppService.preferenceManager.welcomePageDone = newValue }
  }
}
