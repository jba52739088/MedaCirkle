//
//  CircleArticleTagItem.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/18.
//

import UIKit
import TinyConstraints
import RxSwift
import RxCocoa
import RxDataSources

class CircleArticleTagItem: CircleArticleBaseItem {

  var heightConstraints: Constraint?
  private lazy var collectionView: UICollectionView = {
    let flowLayout = LeftAlignedFlowLayout(minimumInteritemSpacing: 9, minimumLineSpacing: 9, sectionInset: .zero)
    flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    let _collectionView = DynamicCollectionView(frame: .zero, collectionViewLayout: flowLayout)
    _collectionView.isScrollEnabled = false
    return _collectionView
  }()

  override func setup() {

    collectionView.do {
      contentView.addSubview($0)
      $0.topToSuperview()
      $0.leftToSuperview(offset: 20)
      $0.rightToSuperview(offset: -20)
      $0.bottomToSuperview(offset: -30)
      $0.width(UIScreen.main.bounds.width - 40)
      $0.register(ArticleTagItem.self, forCellWithReuseIdentifier: "cell")
    }

    UIView().do {
      contentView.addSubview($0)
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.bottomToSuperview()
      $0.height(1)
      $0.backgroundColor = .separator
    }
  }

  override func layoutSubviews() {
    super.layoutSubviews()

  }

  override func didUpdate(viewModel: CircleArticleBaseItemViewModel?) {
    guard let viewModel = viewModel as? CircleArticleTagItemViewModel else { return }

    viewModel.itemRelay
      .observe(on: MainScheduler.instance)
      .bind(to: collectionView.rx.items) { (collectionView, row, element) in
        let indexPath = IndexPath(row: row, section: 0)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ArticleTagItem
        cell.viewModel = ArticleTagItemViewModel(data: element)
        return cell
      }
      .disposed(by: disposeBag)


    collectionView.rx.observe(CGSize.self , "contentSize")
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { _contentSize in
        self.layoutIfNeeded()
      }).disposed(by: disposeBag)

  }
}


