//
//  MemberViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/15.
//

import UIKit

class MemberViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    configView()
    sceneCoordinator.transit(to: .login, by: .overFullScreen, completion: nil)

  }

  private func configView() {
    view.do {
      $0.normalBackgroundGradient()
    }
  }

}
