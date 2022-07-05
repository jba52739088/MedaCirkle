//
//  MemberInfoCell.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/3.
//

import UIKit
import TinyConstraints

class MemberInfoCell: TableViewCell<MemberInfoCellViewModel> {
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
  let circleFriendButton = UIButton(type: .custom)

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


  }

  override func layoutSubviews() {
    super.layoutSubviews()
//    avatarImgView.layer.cornerRadius = 35
//    avatarImgView.layer.masksToBounds = true
//    avatarImgView.layer.borderWidth = 6
//    avatarImgView.layer.borderColor = UIColor.white.cgColor
//    avatarImgView.addShadow(location: .bottom)
//    editButton.layer.cornerRadius = 15
//    editButton.layer.masksToBounds = true
//    editButton.layer.borderWidth = 1
//    editButton.layer.borderColor = UIColor.tappableText.cgColor
//    calendarButton.layer.cornerRadius = 18
//    calendarButton.layer.masksToBounds = true
//    addFriendButton.layer.cornerRadius = 18
//    addFriendButton.layer.masksToBounds = true

  }

  override func didUpdate(viewModel: MemberInfoCellViewModel?) {
    guard let viewModel = viewModel else { return }
//    avatarImgView.image = viewModel.avatar
//    nickNameLabel.attributedText = viewModel.nickNameAttributedString
//    nameLabel.attributedText = viewModel.nameAttributedString
//    editButton.setAttributedTitle(viewModel.editAttributedString, for: .normal)
  }
}


