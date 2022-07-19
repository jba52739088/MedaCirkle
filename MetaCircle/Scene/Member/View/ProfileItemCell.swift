//
//  ProfileItemCell.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/12.
//

import UIKit
import TinyConstraints

class ProfileItemCell: ProfileCell {

  let container = UIView().then {
    $0.backgroundColor = .clear
  }

  let titleLabel = UILabel().then {
    $0.numberOfLines = 1
    $0.textAlignment = .left
  }

  let bedgeLabel = UILabel().then {
    $0.numberOfLines = 1
    $0.textAlignment = .center
  }

  let iconImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }

  override func setup() {
    self.backgroundColor = .clear
    self.selectionStyle = .none

    container.do {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
      $0.backgroundColor = .normalLightBg
      $0.height(80)
      $0.topToSuperview()
      $0.leftToSuperview(offset: 10)
      $0.rightToSuperview(offset: -10)
      $0.bottomToSuperview(offset: -8, usingSafeArea: viewModel?.type == .careerBreak)
    }

    iconImageView.do {
      container.addSubview($0)
      $0.height(16)
      $0.width(16)
      $0.centerYToSuperview()
      $0.rightToSuperview(offset: -26)
    }

    titleLabel.do {
      container.addSubview($0)
      $0.centerYToSuperview()
      $0.leftToSuperview(offset: 20)
    }

    bedgeLabel.do {
      container.addSubview($0)
      $0.centerYToSuperview()
      $0.leftToRight(of: titleLabel, offset: 6)
    }

    iconImageView.do {
      container.addSubview($0)
      $0.width(16)
      $0.height(16)
      $0.centerYToSuperview()
      $0.leftToRight(of: bedgeLabel, offset: 6, relation: .equalOrGreater)
      $0.rightToSuperview(offset: 26)
    }

  }

  override func layoutSubviews() {
    super.layoutSubviews()
    guard let viewModel = viewModel as? ProfileItemCellViewModel else { return }

    container.layer.cornerRadius = 10
    container.layer.masksToBounds = true
    container.addShadow(location: .bottom, opacity: 0.05)

    iconImageView.image = viewModel.icon
  }

  override func didUpdate(viewModel: ProfileCellViewModel?) {
    guard let viewModel = viewModel as? ProfileItemCellViewModel else { return }
    titleLabel.attributedText = viewModel.titleAttributedString
    bedgeLabel.attributedText = viewModel.bedgeAttributedString
    iconImageView.image = viewModel.icon
  }
}

