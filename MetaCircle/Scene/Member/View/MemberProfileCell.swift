//
//  MemberProfileCell.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/4.
//

import UIKit
import TinyConstraints

class MemberProfileCell: TableViewCell<MemberProfileCellViewModel> {
  let container = UIView().then {
    $0.backgroundColor = .clear
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
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
      $0.height(150, relation: .equalOrGreater)
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.bottomToSuperview(offset: -8)
    }

    avatarImgView.do {
      container.addSubview($0)
      $0.height(70)
      $0.width(70)
      $0.leftToSuperview(offset: 30)
      $0.centerYToSuperview()
    }

    nickNameLabel.do {
      container.addSubview($0)
      $0.left(to: avatarImgView, offset: 25)
      $0.top(to: avatarImgView)
      $0.rightToSuperview(offset: -10)
    }

    nameLabel.do {
      container.addSubview($0)
      $0.left(to: avatarImgView, offset: 25)
      $0.topToBottom(of: nickNameLabel)
      $0.rightToSuperview(offset: -10)
    }

    editButton.do {
      container.addSubview($0)
      $0.height(30)
      $0.left(to: avatarImgView, offset: 25)
      $0.topToBottom(of: nameLabel, offset: 13)
      $0.setImage(R.image.icon_btn_user(), for: .normal)
//      $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10.93, bottom: 0, right: -10.93)
    }

    calendarButton.do {
      container.addSubview($0)
      $0.height(36)
      $0.width(36)
      $0.left(to: editButton, offset: 17)
      $0.centerY(to: editButton)
      $0.setImage(R.image.icon_calendar_2_s_white(), for: .normal)
      $0.backgroundColor = .tappableText
    }

    addFriendButton.do {
      container.addSubview($0)
      $0.height(36)
      $0.width(36)
      $0.left(to: calendarButton, offset: 10)
      $0.centerY(to: editButton)
      $0.setImage(R.image.icon_addFriend_2(), for: .normal)
      $0.backgroundColor = .tappableText
    }

  }

  override func layoutSubviews() {
    super.layoutSubviews()
    avatarImgView.layer.cornerRadius = 35
    avatarImgView.layer.masksToBounds = true
    avatarImgView.layer.borderWidth = 6
    avatarImgView.layer.borderColor = UIColor.white.cgColor
    avatarImgView.addShadow(location: .bottom)
    editButton.layer.cornerRadius = 15
    editButton.layer.masksToBounds = true
    editButton.layer.borderWidth = 1
    editButton.layer.borderColor = UIColor.tappableText.cgColor
    calendarButton.layer.cornerRadius = 18
    calendarButton.layer.masksToBounds = true
    addFriendButton.layer.cornerRadius = 18
    addFriendButton.layer.masksToBounds = true

  }

  override func didUpdate(viewModel: MemberProfileCellViewModel?) {
    guard let viewModel = viewModel else { return }
    avatarImgView.image = viewModel.avatar
    nickNameLabel.attributedText = viewModel.nickNameAttributedString
    nameLabel.attributedText = viewModel.nameAttributedString
    editButton.setAttributedTitle(viewModel.editAttributedString, for: .normal)
  }
}


