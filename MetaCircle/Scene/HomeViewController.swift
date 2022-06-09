//
//  HomeViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/15.
//

import UIKit
import TinyConstraints
import Then

class HomeViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    configView()
  }

  private func configView() {
    view.do {
      $0.normalBackgroundGradient()
    }
  }
}
