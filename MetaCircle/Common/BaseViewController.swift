//
//  BaseViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/18.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {

  var disposeBag: DisposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.backgroundColor = .white
  }

  deinit {
    disposeBag = DisposeBag()
  }
}


