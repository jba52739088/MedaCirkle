//
//  CircleContentPinCell.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/14.
//

import UIKit
import TinyConstraints
import RxSwift
import RxCocoa

class CircleContentPinCell: CircleContentBaseCell {
  let container = UIView().then {
    $0.backgroundColor = .normalLightBg
  }

  let titleLabel = UILabel()
  private lazy var collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.itemSize = CGSize(width: 240, height: 374)
    flowLayout.scrollDirection = .horizontal
    return UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
  }()

  override func setup() {
    self.backgroundColor = .clear
    self.selectionStyle = .none

    container.do {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
      $0.backgroundColor = .clear
      $0.height(448)
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.bottomToSuperview()
    }

    titleLabel.do {
      container.addSubview($0)
      $0.leadingToSuperview(offset: 10)
      $0.topToSuperview(offset: 21)
    }

    collectionView.do {
      container.addSubview($0)
      $0.backgroundColor = .clear
      $0.height(374)
      $0.leadingToSuperview()
      $0.rightToSuperview()
      $0.bottomToSuperview(offset: -12)
      $0.register(CircleContentPinItem.self, forCellWithReuseIdentifier: "Cell")
    }

  }

  override func layoutSubviews() {
    super.layoutSubviews()

  }

  override func didUpdate(viewModel: CircleContentBaseCellViewModel?) {
    guard let viewModel = viewModel as? CircleContentPinCellViewModel else { return }
    titleLabel.attributedText = viewModel.titleAttributedString

    viewModel.datasRelay
      .map { $0.compactMap { _ in CircleContentPinItemViewModel() }}
      .bind(to: collectionView.rx.items) { (collectionView, row, element) in
        let indexPath = IndexPath(row: row, section: 0)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CircleContentPinItem
        cell.viewModel = element
        return cell
      }
      .disposed(by: disposeBag)
  }
}
