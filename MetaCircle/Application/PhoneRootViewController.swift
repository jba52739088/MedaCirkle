//
//  PhoneRootViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/25.
//

import UIKit
import RxSwift

class PhoneRootViewController: UIViewController {
  private(set) var content: UIViewController?
  private var splashDidDisappear: VoidBlock?
  private lazy var disposeBag = DisposeBag()

  override var childForStatusBarStyle: UIViewController? {
    return content
  }

  init(splashDidDisappear: VoidBlock?) {
    self.splashDidDisappear = splashDidDisappear
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    showLaunchScreen()
  }

  private func showLaunchScreen() {
    let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "LaunchScreen")

    replaceContentViewController(vc, completion: nil)

    vc.rx.viewDidDisappear.asObservable()
      .withUnretained(self)
      .subscribe(onNext: { $0.0.splashDidDisappear?() })
      .disposed(by: disposeBag)
  }

  func replaceContentViewController(_ viewController: UIViewController, completion: VoidBlock?) {
    let from = content
    let to = viewController
    let container = view!

    content = viewController

    if let from = from { // animated
      replaceChild(from, with: to, completion: completion)
    } else {
      addChild(to)
      container.embedSubview(to.view)
      to.didMove(toParent: self)
      completion?()
    }

    setNeedsStatusBarAppearanceUpdate()
  }
}
