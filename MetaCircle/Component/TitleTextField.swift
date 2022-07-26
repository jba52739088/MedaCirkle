//
//  TitleTextField.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/19.
//

import UIKit
import TinyConstraints
import Then

class TitleTextField: UIView {

  var title: NSAttributedString? {
    didSet {
      titleLabel.attributedText = title
    }
  }
  
  var placeholder: NSAttributedString? {
    didSet {
      txtField.placeholder = placeholder
    }
  }

  var hintString: NSAttributedString? {
    didSet {
      hintLabel.attributedText = hintString
    }
  }

  var errorString: NSAttributedString? {
    didSet {
      errorLabel.attributedText = errorString
      errorImgView.isHidden = errorString == nil
    }
  }

  var showEye: Bool = false {
    didSet {
      setupViews()
    }
  }

  private let titleLabel = UILabel().then {
    $0.numberOfLines = 1
  }

  private(set) var txtField = MetaTextField()

  private let hintView = UIView().then {
    $0.backgroundColor = .clear
  }

  private let hintLabel = UILabel().then {
    $0.numberOfLines = 0
  }

  private let errorImgView = UIImageView()

  private let errorLabel = UILabel().then {
    $0.numberOfLines = 1
  }

  let withTitle: Bool

  init(withTitle: Bool = true) {
    self.withTitle = withTitle
    super.init(frame: CGRect.zero)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  override func layoutSubviews() {
    super.layoutSubviews()
    setupViews()
  }

  func setupViews() {
    backgroundColor = .clear
    titleLabel.do {
      self.addSubview($0)
      $0.attributedText = title
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.height(withTitle ? 22 : 0)
    }

    txtField.do {
      self.addSubview($0)
      $0.height(44)
      $0.topToBottom(of: titleLabel, offset: withTitle ? 5 : 0)
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.layer.cornerRadius = 15
      $0.layer.masksToBounds = true
      $0.showButton = showEye
    }

    hintView.do {
      self.addSubview($0)
      $0.height(20)
      $0.topToBottom(of: txtField, offset: 4)
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.bottomToSuperview()
    }

    hintLabel.do {
      hintView.addSubview($0)
      $0.leftToSuperview(offset: 5)
      $0.rightToSuperview()
      $0.centerYToSuperview()
    }

    errorImgView.do {
      hintView.addSubview($0)
      $0.height(14.2)
      $0.width(15.6)
      $0.image = R.image.icon_error_1()
      $0.contentMode = .scaleAspectFit
      $0.leftToSuperview()
      $0.centerYToSuperview()
    }

    errorLabel.do {
      hintView.addSubview($0)
      $0.leftToRight(of: errorImgView, offset: 5)
      $0.centerYToSuperview()
    }

    errorImgView.isHidden = errorString == nil
  }
}
