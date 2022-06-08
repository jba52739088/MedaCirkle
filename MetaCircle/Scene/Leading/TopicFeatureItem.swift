//
//  TopicFeatureItem.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/8.
//

import UIKit
import TinyConstraints

class TopicFeatureItem: CollectionViewCell<TopicFeatureItemViewModel> {
  let container = UIView().then {
    $0.backgroundColor = .normalLightBg
  }

  let titleLabel = UILabel().then {
    $0.numberOfLines = 1
  }

  let selectedImgView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }

  override func setup() {
    self.backgroundColor = .clear

    container.do {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.bottomToSuperview()
    }

    selectedImgView.do {
      container.addSubview($0)
      $0.height(24)
      $0.width(24)
      $0.image = R.image.icon_check_round()
      $0.centerYToSuperview()
      $0.rightToSuperview(offset: -8)
    }

    titleLabel.do {
      container.addSubview($0)
      $0.centerYToSuperview()
      $0.leftToSuperview(offset: 10)
      $0.right(to: selectedImgView, offset: -10)
      $0.topToSuperview(offset: 10, relation: .equalOrGreater)
      $0.bottomToSuperview(offset: -10, relation: .equalOrLess)
    }


  }

  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = 10
    layer.masksToBounds = true
    layer.borderWidth = 1
    layer.borderColor = UIColor.optionCheckBtnBorder.cgColor
    selectedImgView.isHidden = !(viewModel?.isChoose ?? false)
  }

  override func didUpdate(viewModel: TopicFeatureItemViewModel?) {
    guard let viewModel = viewModel else { return }
    titleLabel.attributedText = viewModel.titleAttributedString
  }
}

