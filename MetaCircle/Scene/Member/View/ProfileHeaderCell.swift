//
//  ProfileHeaderCell.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/12.
//

import UIKit
import TinyConstraints

class ProfileHeaderCell: ProfileCell {
  let container = UIView().then {
    $0.backgroundColor = .clear
  }

  let bannerImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFill
    $0.image = R.image.img_user_banner_01()
  }

  let avatarContainer = UIView().then {
    $0.backgroundColor = .white
  }

  let avatarImgView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }

  let cameraContainer = UIView().then {
    $0.backgroundColor = .white
  }
  let cameraButton = UIButton(type: .custom)

  let nickNameLabel = UILabel().then {
    $0.numberOfLines = 1
    $0.textAlignment = .left
  }

  lazy var nicknameEditButton = UIView.editPenButton(target: self, action: #selector(didTapPenButton(_:)))

  let nameLabel = UILabel().then {
    $0.numberOfLines = 1
    $0.textAlignment = .left
  }

  let genderIcon = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }

  let genderLabel = UILabel().then {
    $0.numberOfLines = 1
    $0.textAlignment = .left
  }

  let birthIcon = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }

  let birthLabel = UILabel().then {
    $0.numberOfLines = 1
    $0.textAlignment = .left
  }

  lazy var nameEditButton = UIView.editPenButton(target: self, action: #selector(didTapPenButton(_:)))

  let introLabel = UILabel().then {
    $0.numberOfLines = 0
    $0.textAlignment = .center
  }

  lazy var introEditButton = UIView.editPenButton(target: self, action: #selector(didTapPenButton(_:)))

  var cellHeightConstraint: Constraint?

  override func setup() {
    self.backgroundColor = .clear
    self.selectionStyle = .none

    container.do {
      contentView.addSubview($0)
      cellHeightConstraint = $0.height(420)
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.width(UIScreen.main.bounds.width)
      $0.bottomToSuperview(offset: -51)
    }

    bannerImageView.do {
      container.addSubview($0)
      $0.height(142)
      $0.rightToSuperview()
      $0.leftToSuperview()
      $0.topToSuperview()
    }

    avatarContainer.do {
      container.addSubview($0)
      $0.height(120)
      $0.width(120)
      $0.centerXToSuperview()
      $0.topToSuperview(offset: 90)
    }

    avatarImgView.do {
      avatarContainer.addSubview($0)
      $0.height(100)
      $0.width(100)
      $0.centerXToSuperview()
      $0.centerYToSuperview()
    }

    cameraContainer.do {
      container.addSubview($0)
      $0.backgroundColor = .white
      $0.height(40)
      $0.width(40)
      $0.right(to: avatarContainer)
      $0.bottom(to: avatarContainer)
    }

    cameraButton.do {
      cameraContainer.addSubview($0)
      $0.backgroundColor = .white
      $0.setImage(R.image.icon_camera(), for: .normal)
      $0.height(40)
      $0.width(40)
      $0.centerXToSuperview()
      $0.centerYToSuperview()
    }

    let nickNameContainer = UIView()
    nickNameContainer.do {
      container.addSubview($0)
      $0.centerXToSuperview()
      $0.height(30)
      $0.topToBottom(of: avatarContainer, offset: 37)
    }

    nickNameLabel.do {
      nickNameContainer.addSubview($0)
      $0.leftToSuperview()
      $0.topToSuperview()
      $0.bottomToSuperview()
    }

    nicknameEditButton.do {
      nickNameContainer.addSubview($0)
      $0.height(30)
      $0.width(30)
      $0.leftToRight(of: nickNameLabel, offset: 2)
      $0.rightToSuperview()
      $0.topToSuperview()
      $0.bottomToSuperview()
      $0.contentEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
    }

    let infoContainer = UIView()
    infoContainer.do {
      container.addSubview($0)
      $0.centerXToSuperview()
      $0.height(27)
      $0.topToBottom(of: nickNameContainer, offset: 23)
    }

    nameLabel.do {
      infoContainer.addSubview($0)
      $0.leftToSuperview()
      $0.topToSuperview()
      $0.bottomToSuperview()
    }

    genderIcon.do {
      infoContainer.addSubview($0)
      $0.topToSuperview(offset: 4)
      $0.bottomToSuperview(offset: -4)
      $0.leftToRight(of: nameLabel, offset: 20)
      $0.centerYToSuperview()
    }

    genderLabel.do {
      infoContainer.addSubview($0)
      $0.leftToRight(of: genderIcon, offset: 1)
      $0.topToSuperview()
      $0.bottomToSuperview()
    }

    birthIcon.do {
      infoContainer.addSubview($0)
      $0.height(20)
      $0.width(20)
      $0.leftToRight(of: genderLabel, offset: 20)
      $0.centerYToSuperview()
    }

    birthLabel.do {
      infoContainer.addSubview($0)
      $0.leftToRight(of: birthIcon, offset: 2)
      $0.topToSuperview()
      $0.bottomToSuperview()
    }

    nameEditButton.do {
      infoContainer.addSubview($0)
      $0.height(30)
      $0.width(30)
      $0.leftToRight(of: birthLabel, offset: 16)
      $0.rightToSuperview()
      $0.centerYToSuperview()
      $0.contentEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
    }

    let introContainer = UIView()
    introContainer.do {
      container.addSubview($0)
      $0.centerXToSuperview()
      $0.topToBottom(of: infoContainer, offset: 23)
      $0.leftToSuperview(offset: 38, relation: .equalOrGreater)
      $0.rightToSuperview(offset: -38, relation: .equalOrLess)
      $0.bottomToSuperview()
    }

    introLabel.do {
      introContainer.addSubview($0)
      $0.leftToSuperview()
      $0.topToSuperview()
      $0.bottomToSuperview()
    }

    introEditButton.do {
      introContainer.addSubview($0)
      $0.height(18)
      $0.width(18)
      $0.leftToRight(of: introLabel, offset: 12)
      $0.rightToSuperview()
      $0.topToSuperview()
      $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 2, bottom: -4, right: -2)
    }

  }

  override func layoutSubviews() {
    super.layoutSubviews()

    bannerImageView.maskRadian()
    cameraButton.layer.cornerRadius = 20
    cameraButton.layer.masksToBounds = true
    cameraContainer.layer.cornerRadius = 20
    cameraContainer.layer.masksToBounds = true
    cameraContainer.addShadow(location: .bottom, color: .black, opacity: 0.1, radius: 13, height: 8)
    avatarImgView.layer.cornerRadius = 50
    avatarImgView.layer.masksToBounds = true

    avatarContainer.layer.cornerRadius = 60
    avatarContainer.layer.masksToBounds = true
    avatarContainer.addShadow(location: .bottom, color: .black, opacity: 0.1, radius: 13, height: 8)


    cellHeightConstraint?.constant = (viewModel as? ProfileHeaderCellViewModel)?.cellHeight() ?? 420
    self.updateConstraints()
  }

  override func didUpdate(viewModel: ProfileCellViewModel?) {
    guard let viewModel = viewModel as? ProfileHeaderCellViewModel else { return }
    cellHeightConstraint?.constant = viewModel.cellHeight()
    avatarImgView.image = viewModel.avatar
    nickNameLabel.attributedText = viewModel.nickNameAttributedString
    nameLabel.attributedText = viewModel.nameAttributedString
    genderIcon.image = viewModel.genderIcon
    genderLabel.attributedText = viewModel.genderAttributedString
    birthIcon.image = viewModel.birthIcon
    birthLabel.attributedText = viewModel.birthAttributedString
    introLabel.attributedText = viewModel.infoAttributedString
  }

  @objc
  private func didTapPenButton(_ sender: UIButton) {

  }
}


