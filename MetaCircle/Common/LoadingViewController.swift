//
//  LoadingViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/22.
//

import UIKit
import TinyConstraints

class LoadingViewController: UIViewController {
  private let loadingView = LoadingView(image: R.image.loading())

  override init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    modalPresentationStyle = .overFullScreen
    modalTransitionStyle = .crossDissolve
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor.black.withAlphaComponent(0.5)

    loadingView.do {
      view.addSubview($0)
      $0.height(50.2)
      $0.width(50.2)
      $0.centerXToSuperview()
      $0.centerYToSuperview()
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    loadingView.startAnimating()
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    loadingView.stopAnimating()
  }

}

