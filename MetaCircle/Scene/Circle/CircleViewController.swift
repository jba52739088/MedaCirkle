//
//  CircleViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/14.
//

import UIKit
import TinyConstraints
import RxSwift
import RxCocoa

class CircleViewController: BaseViewController {

  private lazy var collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    return UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
  }()
  let toolBar = UIView().then {
    $0.backgroundColor = .normalLightBg
  }

  let viewModel: CircleViewModel

  init(_ viewModel: CircleViewModel = CircleViewModel()) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    disposeBag = DisposeBag()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

  }

}
