//
//  EditSocialMediaCell.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/20.
//

import UIKit
import TinyConstraints

class EditSocialMediaCell: TableViewCell<EditSocialMediaCellViewModel> {

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

  let addButton = UIButton(type: .custom)

  override func setup() {
    self.backgroundColor = .clear
    self.selectionStyle = .none

    container.do {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
      $0.height(64)
      $0.topToSuperview()
      $0.leftToSuperview(offset: 10)
      $0.rightToSuperview(offset: -10)
      $0.bottomToSuperview(offset: -10)
    }

    iconImage.do {
      container.addSubview($0)
      $0.height(40)
      $0.width(40)
      $0.centerYToSuperview()
      $0.leftToSuperview(offset: 26)
    }

    titleLabel.do {
      container.addSubview($0)
      $0.centerYToSuperview()
      $0.leftToRight(of: iconImage, offset: 10)
    }

    addButton.do {
      container.addSubview($0)
      $0.setImage(R.image.icon_btn_pluss(), for: .normal)
      $0.height(26)
      $0.centerYToSuperview()
      $0.rightToSuperview(offset: -26)
      $0.leftToRight(of: titleLabel, offset: 10, relation: .equalOrGreater)
      $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -3, bottom: 0, right: 3)
      $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: -3)
      $0.contentEdgeInsets = UIEdgeInsets(top: 2, left: 12, bottom: 2, right: 12)
      $0.backgroundColor = .btnBlue
    }
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    addButton.layer.cornerRadius = 13
    addButton.layer.masksToBounds = true
  }

  override func didUpdate(viewModel: EditSocialMediaCellViewModel?) {
    guard let viewModel = viewModel else { return }
    titleLabel.attributedText = viewModel.titleAttributedString
    iconImage.image = viewModel.type.icon
    addButton.setAttributedTitle(viewModel.buttonAttributedString, for: .normal)
  }
}

