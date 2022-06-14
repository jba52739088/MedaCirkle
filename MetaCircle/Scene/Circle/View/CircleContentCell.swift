//
//  CircleContentCell.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/14.
//

import UIKit
import TinyConstraints

class CircleContentCell: CircleContentBaseCell {

  let container = UIView().then {
    $0.backgroundColor = .normalLightBg
  }
  private lazy var menuButton: UIButton = .menuButton(target: self, action: #selector(didTapMenuButton))
  let avatar = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  let authorLabel = UILabel().then {
    $0.numberOfLines = 1
  }
  let medalImage = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  let rankLabel = UILabel().then {
    $0.numberOfLines = 1
  }
  let dateLabel = UILabel().then {
    $0.numberOfLines = 1
  }
  let titleLabel = UILabel().then {
    $0.numberOfLines = 2
  }

  let contentLabel = UILabel().then {
    $0.numberOfLines = 3
  }

  let tagButton = UIButton()
  let readMoreButton = UIButton()
  private lazy var awesomeButton: UIButton = .menuButton(target: self, action: #selector(didTapMenuButton))
  private lazy var replyButton: UIButton = .menuButton(target: self, action: #selector(didTapMenuButton))
  private lazy var bookmarkButton: UIButton = .menuButton(target: self, action: #selector(didTapMenuButton))
  private lazy var shareButton: UIButton = .menuButton(target: self, action: #selector(didTapMenuButton))

  override func setup() {
    self.backgroundColor = .clear

    container.do {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
      $0.height(374)
      $0.topToSuperview()
      $0.leftToSuperview(offset: 10)
      $0.rightToSuperview(offset: -10)
      $0.bottomToSuperview(offset: -8)
    }

    avatar.do {
      container.addSubview($0)
      $0.height(43)
      $0.width(43)
      $0.topToSuperview(offset: 13)
      $0.leftToSuperview(offset: 10)
    }

    menuButton.do {
      container.addSubview($0)
      $0.height(16)
      $0.width(16)
      $0.centerY(to: avatar)
      $0.rightToSuperview(offset: -17)
    }

    authorLabel.do {
      container.addSubview($0)
      $0.leftToRight(of: avatar, offset: 7)
      $0.rightToLeft(of: menuButton, offset: -10, relation: .equalOrLess)
      $0.top(to: avatar)
    }

    medalImage.do {
      container.addSubview($0)
      $0.height(20)
      $0.width(12)
      $0.bottom(to: avatar)
      $0.leftToRight(of: avatar, offset: 7)
    }

    rankLabel.do {
      container.addSubview($0)
      $0.centerY(to: medalImage)
      $0.leftToRight(of: medalImage, offset: 3)
    }

    let dot = UIView()
    dot.do {
      container.addSubview($0)
      $0.height(4)
      $0.width(4)
      $0.centerY(to: medalImage)
      $0.leftToRight(of: rankLabel, offset: 5)
      $0.backgroundColor = .dotBlack
    }

    dateLabel.do {
      container.addSubview($0)
      $0.centerY(to: medalImage)
      $0.leftToRight(of: dot, offset: 5)
      $0.rightToLeft(of: menuButton, offset: -10, relation: .equalOrLess)
    }

    titleLabel.do {
      container.addSubview($0)
      $0.leftToSuperview(offset: 10)
      $0.rightToSuperview(offset: -10)
      $0.topToBottom(of: avatar, offset: 15)
    }

    contentLabel.do {
      container.addSubview($0)
      $0.leftToSuperview(offset: 10)
      $0.rightToSuperview(offset: -10)
      $0.topToBottom(of: titleLabel, offset: 12)
    }

    tagButton.do {
      container.addSubview($0)
      $0.height(26)
      $0.topToBottom(of: contentLabel, offset: 14)
      $0.leftToSuperview(offset: 10)
      $0.contentEdgeInsets = UIEdgeInsets(top: 3, left: 16, bottom: 3, right: 16)
      $0.backgroundColor = .tagBlue
    }

    readMoreButton.do {
      container.addSubview($0)
      $0.topToBottom(of: tagButton, offset: 14)
      $0.leftToSuperview(offset: 10)
    }

    let separator = UIView()
    separator.do {
      container.addSubview($0)
      $0.bottomToSuperview(offset: -49.5)
      $0.leftToSuperview(offset: 10)
      $0.rightToSuperview(offset: -10)
      $0.height(1)
      $0.backgroundColor = .separator
    }

    awesomeButton.do {
      container.addSubview($0)
      $0.setImage(R.image.icon_awesome_26(), for: .normal)
      $0.height(22)
      $0.width(22)
      $0.topToBottom(of: separator, offset: 10.5)
      $0.leftToSuperview(offset: 15)
    }

    replyButton.do {
      container.addSubview($0)
      $0.setImage(R.image.icon_reply_26(), for: .normal)
      $0.height(22)
      $0.width(22)
      $0.centerY(to: awesomeButton)
      $0.leftToRight(of: awesomeButton, offset: 15)
    }

    bookmarkButton.do {
      container.addSubview($0)
      $0.setImage(R.image.icon_bookmark_26(), for: .normal)
      $0.height(22)
      $0.width(22)
      $0.centerY(to: awesomeButton)
      $0.leftToRight(of: replyButton, offset: 15)
    }

    shareButton.do {
      container.addSubview($0)
      $0.setImage(R.image.icon_share_01_26(), for: .normal)
      $0.height(22)
      $0.width(22)
      $0.centerY(to: awesomeButton)
      $0.rightToSuperview(offset: -15)
    }
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    container.layer.cornerRadius = 10
    container.layer.masksToBounds = true
    avatar.layer.cornerRadius = 21.5
    avatar.layer.masksToBounds = true
    tagButton.layer.cornerRadius = 13
    tagButton.layer.masksToBounds = true
    //    layer.borderWidth = 1
    //    layer.borderColor = UIColor.optionCheckBtnBorder.cgColor
    //    selectedImgView.isHidden = !(viewModel?.isChoose ?? false)
  }

  override func didUpdate(viewModel: CircleContentBaseCellViewModel?) {
    guard let viewModel = viewModel as? CircleContentCellViewModel else { return }
    avatar.image = R.image.img_avatar_1()
    medalImage.image = R.image.icon_medal_1()
    authorLabel.attributedText = viewModel.authorAttributedString
    rankLabel.attributedText = viewModel.rankAttributedString
    dateLabel.attributedText = viewModel.dateAttributedString
    titleLabel.attributedText = viewModel.titleAttributedString
    contentLabel.attributedText = viewModel.contentAttributedString
    tagButton.setAttributedTitle(viewModel.tagAttributedString("設計"), for: .normal)
    readMoreButton.setAttributedTitle(viewModel.readmoreAttributedString, for: .normal)
  }

  @objc func didTapMenuButton() {
    print("didTapMenuButton")

  }
}

