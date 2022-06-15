//
//  CircleCell.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/31.
//

import UIKit
import TinyConstraints

class CircleMainCell: TableViewCell<CircleMainCellViewModel> {
  let container = UIView().then {
    $0.backgroundColor = .normalLightBg
  }
  let avatarImgView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  let privacyImgView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  let titleLabel = UILabel().then {
    $0.numberOfLines = 1
    $0.textAlignment = .left
  }
  let verifiedImgView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  let descriptionLabel = UILabel().then {
    $0.numberOfLines = 1
  }
  let badgeView = UIView().then {
    $0.backgroundColor = .badgeRed
  }
  let badgeLabel = UILabel().then {
    $0.numberOfLines = 1
  }

  override func setup() {
    self.backgroundColor = .clear
    self.selectionStyle = .none

    container.do {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
      $0.height(80, relation: .equalOrGreater)
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.bottomToSuperview(offset: -8)
    }

    avatarImgView.do {
      container.addSubview($0)
      $0.height(56)
      $0.width(56)
      $0.leftToSuperview(offset: 15)
      $0.centerYToSuperview()
    }

    privacyImgView.do {
      container.addSubview($0)
      $0.height(25)
      $0.width(25)
      $0.leftToSuperview(offset: 49)
      $0.bottomToSuperview(offset: -13)
    }

    titleLabel.do {
      container.addSubview($0)
      $0.topToSuperview(offset: 16)
      $0.leftToRight(of: avatarImgView, offset: 16)
    }

    verifiedImgView.do {
      container.addSubview($0)
      $0.height(16.38)
      $0.width(17.14)
      $0.image = R.image.icon_colour_tick()
      $0.centerY(to: titleLabel)
      $0.leftToRight(of: titleLabel, offset: 4)
      $0.isHidden = true
    }

    descriptionLabel.do {
      container.addSubview($0)
      $0.bottomToSuperview(offset: -16)
      $0.leftToRight(of: avatarImgView, offset: 16)
    }

    badgeView.do {
      container.addSubview($0)
      $0.width(21, relation: .equalOrGreater)
      $0.height(21)
      $0.centerYToSuperview()
      $0.rightToSuperview(offset: -12)
      $0.leftToRight(of: verifiedImgView, offset: 10, relation: .equalOrGreater)
      $0.leftToRight(of: descriptionLabel, offset: 10, relation: .equalOrGreater)
    }

    badgeLabel.do {
      badgeView.addSubview($0)
      $0.centerYToSuperview()
      $0.rightToSuperview(offset: -5)
      $0.leftToSuperview(offset: 5)
    }
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    container.layer.cornerRadius = 10
    container.layer.masksToBounds = true
    avatarImgView.layer.cornerRadius = 28
    avatarImgView.layer.masksToBounds = true
    privacyImgView.layer.cornerRadius = 12.5
    privacyImgView.layer.masksToBounds = true
    badgeView.layer.cornerRadius = 10.5
    badgeView.layer.masksToBounds = true
  }

  override func didUpdate(viewModel: CircleMainCellViewModel?) {
    guard let viewModel = viewModel else { return }
    avatarImgView.image = viewModel.data.image
    privacyImgView.image = viewModel.data.privacyType.image
    titleLabel.attributedText = viewModel.titleAttributedString
    descriptionLabel.attributedText = viewModel.subTitleAttributedString
    badgeLabel.attributedText = viewModel.bedgeAttributedString
    badgeView.isHidden = badgeLabel.attributedText?.string == ""
  }
}

