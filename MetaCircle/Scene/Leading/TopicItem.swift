//
//  TopicItem.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/8.
//

import UIKit
import TinyConstraints

class TopicItem: CollectionViewCell<TopicItemViewModel> {
  let container = UIView().then {
    $0.backgroundColor = .normalLightBg
  }

  let imgBgView = UIView().then {
    $0.backgroundColor = .normalLightBg
  }

  let imgView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }

  let titleLabel = UILabel().then {
    $0.numberOfLines = 1
  }

  let selectedBadge = UILabel().then {
    $0.numberOfLines = 1
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

    imgBgView.do {
      container.addSubview($0)
      $0.topToSuperview()
      $0.centerXToSuperview()
      $0.width(70)
      $0.height(70)
    }

    imgView.do {
      imgBgView.addSubview($0)
      $0.height(52)
      $0.width(52)
      $0.centerYToSuperview()
      $0.centerXToSuperview()
    }

    titleLabel.do {
      container.addSubview($0)
      $0.bottomToSuperview()
      $0.leftToSuperview()
      $0.rightToSuperview()
    }

    selectedBadge.do {
      container.addSubview($0)
      $0.height(24)
      $0.width(24)
      $0.backgroundColor = .textBlue
      $0.bottomToSuperview(offset: -27.5)
      $0.rightToSuperview(offset: -9.5)
    }

    layoutIfNeeded()

    imgBgView.circleGradient()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    imgBgView.layer.cornerRadius = 35
    imgBgView.layer.masksToBounds = true
    imgView.layer.cornerRadius = 26
    imgView.layer.masksToBounds = true
    selectedBadge.layer.cornerRadius = 13
    selectedBadge.layer.masksToBounds = true
//    imgBgView.circleGradient()
    selectedBadge.isHidden = !(viewModel?.isChoose ?? false)
    selectedBadge.attributedText = viewModel?.badgeAttributedString(3)
  }

  override func didUpdate(viewModel: TopicItemViewModel?) {
    guard let viewModel = viewModel else { return }
    imgView.image = viewModel.data.image
    titleLabel.attributedText = viewModel.titleAttributedString
  }
}

