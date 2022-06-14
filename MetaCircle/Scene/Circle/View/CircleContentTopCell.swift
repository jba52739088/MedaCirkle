//
//  CircleContentTopCell.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/10.
//

import UIKit
import TinyConstraints

class CircleContentTopCell: CircleContentBaseCell {
  let container = UIView().then {
    $0.backgroundColor = .normalLightBg
  }

  let bannerView = UIView()
  let bannerImage = UIImageView()

  private lazy var backButton: UIButton = .backButton(target: self, action: #selector(didTapBackButton))
  private lazy var searchButton: UIButton = .searchButton(target: self, action: #selector(didTapSearchButton))
  private lazy var menuButton: UIButton = .menuButton(target: self, action: #selector(didTapMenuButton))
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
  let subscribeView = UIView()
  let inviteButton = UIView()
  private lazy var albumButton: UIButton = .circleContentButton(target: self, action: #selector(didTapAlbumButton))
  private lazy var calendarButton: UIButton = .circleContentButton(target: self, action: #selector(didTapCalendarButton))
  private lazy var fileButton: UIButton = .circleContentButton(target: self, action: #selector(didTapFileButton))
  private lazy var introButton: UIButton = .circleContentButton(target: self, action: #selector(didTapIntroButton))

  override func setup() {
    self.backgroundColor = .clear
    self.selectionStyle = .none

    container.do {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
      $0.height(256, relation: .equalOrGreater)
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.bottomToSuperview()
    }

    bannerView.do {
      container.addSubview($0)
      $0.height(100)
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.topToSuperview()
      $0.backgroundColor = .normalLightBg
    }

    bannerImage.do {
      bannerView.addSubview($0)
      $0.bottomToSuperview()
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.topToSuperview()
      $0.backgroundColor = .clear
      $0.contentMode = .scaleAspectFill
      $0.clipsToBounds = true
    }

    backButton.do {
      bannerView.addSubview($0)
      $0.height(30)
      $0.width(30)
      $0.leftToSuperview(offset: 10)
      $0.topToSuperview(offset: 10)
      $0.backgroundColor = .normalLightBg.withAlphaComponent(0.8)
    }

    menuButton.do {
      bannerView.addSubview($0)
      $0.height(30)
      $0.width(30)
      $0.rightToSuperview(offset: -10)
      $0.topToSuperview(offset: 10)
      $0.backgroundColor = .normalLightBg.withAlphaComponent(0.8)
    }

    searchButton.do {
      bannerView.addSubview($0)
      $0.height(30)
      $0.width(30)
      $0.rightToLeft(of: menuButton, offset: -10)
      $0.topToSuperview(offset: 10)
      $0.backgroundColor = .normalLightBg.withAlphaComponent(0.8)
    }

    avatarImgView.do {
      container.addSubview($0)
      $0.topToBottom(of: bannerView, offset: 10)
      $0.height(56)
      $0.width(56)
      $0.leftToSuperview(offset: 17)
    }

    privacyImgView.do {
      container.addSubview($0)
      $0.height(25)
      $0.width(25)
      $0.leftToSuperview(offset: 52)
      $0.bottom(to: avatarImgView, offset: 4)
    }

    titleLabel.do {
      container.addSubview($0)
      $0.centerY(to: avatarImgView)
      $0.leftToRight(of: avatarImgView, offset: 12)
      $0.width(167, relation: .equalOrLess)
      $0.height(to: avatarImgView, relation: .equalOrLess)
      $0.textAlignment = .left
    }

    verifiedImgView.do {
      container.addSubview($0)
      $0.height(16.38)
      $0.width(17.14)
      $0.image = R.image.icon_colour_tick()
      $0.top(to: titleLabel, offset: 6)
      $0.leftToRight(of: titleLabel, offset: 4)
      $0.isHidden = false
    }

    subscribeView.do {
      container.addSubview($0)
      $0.height(56)
      $0.width(66)
      $0.top(to: avatarImgView)
      $0.rightToSuperview(offset: -13)
      $0.isHidden = false
    }

    inviteButton.do {
      container.addSubview($0)
      $0.backgroundColor = .btnBlue
      $0.height(26)
      $0.width(66)
      $0.topToBottom(of: subscribeView, offset: 9)
      $0.rightToSuperview(offset: -13)
      $0.isHidden = false
    }

    albumButton.do {
      container.addSubview($0)
      $0.height(20)
      $0.topToBottom(of: inviteButton, offset: 15.5)
      $0.rightToSuperview(offset: -31)
      $0.setImage(R.image.icon_w18_grey_album(), for: .normal)
    }

    calendarButton.do {
      container.addSubview($0)
      $0.height(20)
      $0.centerY(to: albumButton)
      $0.rightToLeft(of: albumButton, offset: -22)
      $0.setImage(R.image.icon_w18_grey_calendar(), for: .normal)
    }

    fileButton.do {
      container.addSubview($0)
      $0.height(20)
      $0.centerY(to: albumButton)
      $0.rightToLeft(of: calendarButton, offset: -22)
      $0.setImage(R.image.icon_w18_grey_resource(), for: .normal)
    }

    introButton.do {
      container.addSubview($0)
      $0.height(20)
      $0.centerY(to: albumButton)
      $0.rightToLeft(of: fileButton, offset: -22)
      $0.setImage(R.image.icon_w18_grey_paper(), for: .normal)
    }

    UIView().do {
      container.addSubview($0)
      $0.height(1)
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.bottomToSuperview()
      $0.backgroundColor = .separator
    }

  }

  override func layoutSubviews() {
    super.layoutSubviews()
    backButton.layer.cornerRadius = 15
    backButton.layer.masksToBounds = true
    searchButton.layer.cornerRadius = 15
    searchButton.layer.masksToBounds = true
    menuButton.layer.cornerRadius = 15
    menuButton.layer.masksToBounds = true
    avatarImgView.layer.cornerRadius = 28
    avatarImgView.layer.masksToBounds = true
    privacyImgView.layer.cornerRadius = 12.5
    privacyImgView.layer.masksToBounds = true
    bannerImage.image = R.image.img_banner_05()
    bannerImage.maskRadian()
    subscribeView.layer.cornerRadius = 15
    subscribeView.layer.borderColor = UIColor.optionCheckBtnBorder.cgColor
    subscribeView.layer.borderWidth = 1
    subscribeView.layer.masksToBounds = true
    inviteButton.layer.cornerRadius = 13
    inviteButton.layer.masksToBounds = true

  }

  override func didUpdate(viewModel: CircleContentBaseCellViewModel?) {
    guard let viewModel = viewModel as? CircleContentTopCellViewModel else { return }
    avatarImgView.image = viewModel.data.image
    privacyImgView.image = viewModel.data.privacyType.image
    titleLabel.attributedText = viewModel.titleAttributedString
    albumButton.setAttributedTitle(viewModel.albumAttributedString, for: .normal)
    calendarButton.setAttributedTitle(viewModel.calendarAttributedString, for: .normal)
    fileButton.setAttributedTitle(viewModel.filesAttributedString, for: .normal)
    introButton.setAttributedTitle(viewModel.introAttributedString, for: .normal)
  }
}

private
extension CircleContentTopCell {

  @objc func didTapBackButton() {
    print("didTapBackButton")
    sceneCoordinator.dismiss(animated: true, completion: nil)
  }

  @objc func didTapSearchButton() {
    print("didTapSearchButton")

  }

  @objc func didTapMenuButton() {
    print("didTapMenuButton")

  }

  @objc func didTapAlbumButton() {
    print("didTapAlbumButton")

  }

  @objc func didTapCalendarButton() {
    print("didTapCalendarButton")

  }

  @objc func didTapFileButton() {
    print("didTapFileButton")

  }

  @objc func didTapIntroButton() {
    print("didTapIntroButton")

  }
}


