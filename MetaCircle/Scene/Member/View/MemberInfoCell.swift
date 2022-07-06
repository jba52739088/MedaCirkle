//
//  MemberInfoCell.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/3.
//

import UIKit
import TinyConstraints

class MemberInfoCell: MemberCell {
  let container = UIView().then {
    $0.backgroundColor = .clear
  }

  let coinLabel = UILabel().then {
    $0.numberOfLines = 1
    $0.textAlignment = .left
  }

  let coinCountLabel = UILabel().then {
    $0.numberOfLines = 1
    $0.textAlignment = .center
  }

  let friendLabel = UILabel().then {
    $0.numberOfLines = 1
    $0.textAlignment = .left
  }

  let friendCountLabel = UILabel().then {
    $0.numberOfLines = 1
    $0.textAlignment = .center
  }

  let circleLabel = UILabel().then {
    $0.numberOfLines = 1
    $0.textAlignment = .left
  }

  let circleCountLabel = UILabel().then {
    $0.numberOfLines = 1
    $0.textAlignment = .center
  }

  let coinButton = UIButton(type: .custom)
  let friendButton = UIButton(type: .custom)
  let circleButton = UIButton(type: .custom)

  override func setup() {
    self.backgroundColor = .clear
    self.selectionStyle = .none

    container.do {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
      $0.height(94, relation: .equalOrGreater)
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.bottomToSuperview(offset: -8)
    }

    let friendView = UIView()
    friendView.do {
      container.addSubview($0)
      $0.centerXToSuperview()
      $0.topToSuperview()
      $0.height(74)
      $0.width(99)
      $0.layer.cornerRadius = 10
      $0.layer.masksToBounds = true
    }

    friendButton.do {
      friendView.addSubview($0)
      $0.setBackgroundImage(R.image.userItemBg(), for: .normal)
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.bottomToSuperview()
    }

    let friendImage = UIImageView()
    friendImage.do {
      friendView.addSubview($0)
      $0.height(22)
      $0.width(22)
      $0.topToSuperview(offset: 9)
      $0.leftToSuperview(offset: 20)
      $0.image = R.image.icon_friends_line()
    }

    friendLabel.do {
      friendView.addSubview($0)
      $0.centerY(to: friendImage)
      $0.leftToRight(of: friendImage, offset: 5)
    }

    friendCountLabel.do {
      friendView.addSubview($0)
      $0.centerXToSuperview()
      $0.topToBottom(of: friendLabel, offset: 3)
    }

    let coinView = UIView()
    coinView.do {
      container.addSubview($0)
      $0.rightToLeft(of: friendView, offset: -15)
      $0.topToSuperview()
      $0.height(74)
      $0.width(99)
      $0.layer.cornerRadius = 10
      $0.layer.masksToBounds = true
    }

    coinButton.do {
      coinView.addSubview($0)
      $0.setBackgroundImage(R.image.userItemBg(), for: .normal)
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.bottomToSuperview()
    }

    let coinImage = UIImageView()
    coinImage.do {
      coinView.addSubview($0)
      $0.height(22)
      $0.width(22)
      $0.topToSuperview(offset: 9)
      $0.leftToSuperview(offset: 20)
      $0.image = R.image.icon_coin_22()
    }

    coinLabel.do {
      coinView.addSubview($0)
      $0.centerY(to: coinImage)
      $0.leftToRight(of: coinImage, offset: 5)
    }

    coinCountLabel.do {
      coinView.addSubview($0)
      $0.centerXToSuperview()
      $0.topToBottom(of: coinLabel, offset: 3)
    }

    let circleView = UIView()
    circleView.do {
      container.addSubview($0)
      $0.leftToRight(of: friendView, offset: 15)
      $0.topToSuperview()
      $0.height(74)
      $0.width(99)
      $0.layer.cornerRadius = 10
      $0.layer.masksToBounds = true
    }

    circleButton.do {
      circleView.addSubview($0)
      $0.setBackgroundImage(R.image.userItemBg(), for: .normal)
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.bottomToSuperview()
    }

    let circleImage = UIImageView()
    circleImage.do {
      circleView.addSubview($0)
      $0.height(22)
      $0.width(22)
      $0.topToSuperview(offset: 9)
      $0.leftToSuperview(offset: 20)
      $0.image = R.image.icon_member_20_circle()
    }

    circleLabel.do {
      circleView.addSubview($0)
      $0.centerY(to: circleImage)
      $0.leftToRight(of: circleImage, offset: 5)
    }

    circleCountLabel.do {
      circleView.addSubview($0)
      $0.centerXToSuperview()
      $0.topToBottom(of: circleLabel, offset: 3)
    }
  }

  override func layoutSubviews() {
    super.layoutSubviews()

  }

  override func didUpdate(viewModel: MemberCellViewModel?) {
    guard let viewModel = viewModel as? MemberInfoCellViewModel else { return }
    coinLabel.attributedText = viewModel.coinTitleAttributedString
    friendLabel.attributedText = viewModel.friendTitleAttributedString
    circleLabel.attributedText = viewModel.circleTitleAttributedString
    coinCountLabel.attributedText = viewModel.coinCountTitleAttributedString
    friendCountLabel.attributedText = viewModel.friendCountTitleAttributedString
    circleCountLabel.attributedText = viewModel.circleCountTitleAttributedString
  }
}


