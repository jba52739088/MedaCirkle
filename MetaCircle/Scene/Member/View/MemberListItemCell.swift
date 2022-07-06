//
//  MemberIistItemCell.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/6.
//

import UIKit
import TinyConstraints

class MemberListItemCell: MemberCell {

  let container = UIView().then {
    $0.backgroundColor = .clear
  }

  let iconImage = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }

  let titleLabel = UILabel().then {
    $0.numberOfLines = 1
    $0.textAlignment = .left
  }

  let iconArrow = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }

  let separator = UIView().then {
    $0.backgroundColor = .separator
  }

  let logoutLabel = UILabel().then {
    $0.numberOfLines = 1
    $0.textAlignment = .center
  }

  var heightConstraint: Constraint?

  override func setup() {
    self.backgroundColor = .clear
    self.selectionStyle = .none

    container.do {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
      self.heightConstraint = $0.height(44)
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.bottomToSuperview()
    }

    iconImage.do {
      container.addSubview($0)
      $0.height(22)
      $0.width(22)
      $0.centerYToSuperview()
      $0.leftToSuperview(offset: 14)
    }

    iconArrow.do {
      container.addSubview($0)
      $0.height(14)
      $0.width(14)
      $0.centerYToSuperview()
      $0.rightToSuperview(offset: -10)
      $0.image = R.image.icon_arrow_2_right()
    }

    titleLabel.do {
      container.addSubview($0)
      $0.centerYToSuperview()
      $0.leftToRight(of: iconImage, offset: 16)
      $0.rightToLeft(of: iconArrow, offset: -10, relation: .equalOrLess)
    }

    separator.do {
      container.addSubview($0)
      $0.height(1)
      $0.widthToSuperview()
      $0.centerYToSuperview()
    }

    logoutLabel.do {
      container.addSubview($0)
      $0.topToSuperview()
      $0.centerXToSuperview()
    }
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    guard let viewModel = viewModel else { return }
    heightConstraint?.constant = viewModel.cellHeight()
    iconImage.isHidden = viewModel.type == .separator
    iconArrow.isHidden = viewModel.type == .separator || viewModel.type == .logout
    titleLabel.isHidden = viewModel.type == .separator || viewModel.type == .logout
    separator.isHidden = viewModel.type != .separator
    logoutLabel.isHidden = viewModel.type != .logout
  }

  override func didUpdate(viewModel: MemberCellViewModel?) {
    guard let viewModel = viewModel as? MemberListItemCellViewModel else { return }
    heightConstraint?.constant = viewModel.cellHeight()
    titleLabel.attributedText = viewModel.titleAttributedString
    logoutLabel.attributedText = viewModel.titleAttributedString
    iconImage.image = viewModel.type.icon
  }
}
