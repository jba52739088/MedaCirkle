//
//  MemberProfileCell.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/4.
//

import UIKit
import TinyConstraints

class MemberProfileCell: MemberCell {
  let container = UIView().then {
    $0.backgroundColor = .clear
  }

  let avatarContainer = UIView().then {
    $0.backgroundColor = .white
  }

  let avatarImgView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }

  let nickNameLabel = UILabel().then {
    $0.numberOfLines = 1
    $0.textAlignment = .left
  }

  let nameLabel = UILabel().then {
    $0.numberOfLines = 1
    $0.textAlignment = .left
  }

  let editButton = UIButton(type: .custom)
  let calendarButton = UIButton(type: .custom)
  let addFriendButton = UIButton(type: .custom)

  override func setup() {
    self.backgroundColor = .clear
    self.selectionStyle = .none

    container.do {
      contentView.addSubview($0)
      $0.height(150)
      $0.width(326)
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.bottomToSuperview()
    }

    avatarContainer.do {
      container.addSubview($0)
      $0.height(82)
      $0.width(82)
      $0.leftToSuperview()
      $0.topToSuperview(offset: 22)
    }

    avatarImgView.do {
      avatarContainer.addSubview($0)
      $0.height(70)
      $0.width(70)
      $0.centerXToSuperview()
      $0.centerYToSuperview()
    }

    nickNameLabel.do {
      container.addSubview($0)
      $0.leftToRight(of: avatarContainer, offset: 19)
      $0.topToSuperview(offset: 17)
      $0.rightToSuperview(offset: -10)
    }

    nameLabel.do {
      container.addSubview($0)
      $0.leftToRight(of: avatarContainer, offset: 19)
      $0.topToBottom(of: nickNameLabel)
      $0.rightToSuperview(offset: -10)
    }

    editButton.do {
      container.addSubview($0)
      $0.height(30)
      $0.leftToRight(of: avatarContainer, offset: 19)
      $0.topToBottom(of: nameLabel, offset: 13)
      $0.setImage(R.image.icon_btn_user(), for: .normal)
      $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
      $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: -5)
      $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
    }

    calendarButton.do {
      container.addSubview($0)
      $0.height(36)
      $0.width(36)
      $0.leftToRight(of: editButton, offset: 17)
      $0.centerY(to: editButton)
      $0.setImage(R.image.icon_calendar_2_s_white(), for: .normal)
      $0.backgroundColor = .btnBlue
    }

    addFriendButton.do {
      container.addSubview($0)
      $0.height(36)
      $0.width(36)
      $0.leftToRight(of: calendarButton, offset: 10)
      $0.centerY(to: editButton)
      $0.setImage(R.image.icon_addFriend_2(), for: .normal)
      $0.backgroundColor = .btnBlue
    }

  }

  override func layoutSubviews() {
    super.layoutSubviews()
    avatarImgView.layer.cornerRadius = 35
    avatarImgView.layer.masksToBounds = true

    avatarContainer.layer.cornerRadius = 41
    avatarContainer.layer.masksToBounds = true
    avatarContainer.addShadow(location: .bottom, color: .black, opacity: 0.1, radius: 13, height: 8)

    editButton.layer.cornerRadius = 15
    editButton.layer.masksToBounds = true
    editButton.layer.borderWidth = 1
    editButton.layer.borderColor = UIColor.btnBlue.cgColor
    calendarButton.layer.cornerRadius = 18
    calendarButton.layer.masksToBounds = true
    addFriendButton.layer.cornerRadius = 18
    addFriendButton.layer.masksToBounds = true

  }

  override func didUpdate(viewModel: MemberCellViewModel?) {
    guard let viewModel = viewModel as? MemberProfileCellViewModel else { return }
    avatarImgView.image = viewModel.avatar
    nickNameLabel.attributedText = viewModel.nickNameAttributedString
    nameLabel.attributedText = viewModel.nameAttributedString
    editButton.setAttributedTitle(viewModel.editAttributedString, for: .normal)
  }
}


