//
//  FullScreenLoadingPresenting.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/22.
//

import UIKit

protocol FullScreenLoadingPresenting {
  var loadingVC: LoadingViewController { get }
}

extension FullScreenLoadingPresenting where Self: UIViewController {
  var topViewController: UIViewController? {
    guard var topViewController = presentedViewController, !topViewController.isBeingDismissed else { return nil }
    while let presentedViewController = topViewController.presentedViewController,
      !presentedViewController.isBeingDismissed {
        topViewController = presentedViewController
    }
    return topViewController
  }

  func showLoading(completion: (() -> Void)? = nil) {
    guard topViewController != loadingVC else { return }
    if let topVC = topViewController {
      topVC.present(loadingVC, animated: true, completion: completion)
    } else {
      present(loadingVC, animated: true, completion: completion)
    }
  }

  func hideLoading(completion: (() -> Void)? = nil) {
    guard topViewController == loadingVC else { return }
    loadingVC.dismiss(animated: true, completion: completion)
  }
}

