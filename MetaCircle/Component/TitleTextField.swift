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
      txtField.attributedPlaceholder = placeholder
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

  private let txtView = UIView().then {
    $0.backgroundColor = .textFieldNormalBg
  }

  private let eyeButton = UIButton(type: .custom)

  private(set) var txtField = UITextField().then {
    $0.borderStyle = .none
  }

  private let errorView = UIView().then {
    $0.backgroundColor = .clear
  }

  private let errorImgView = UIImageView()

  private let errorLabel = UILabel().then {
    $0.numberOfLines = 1
  }


  init() {
    super.init(frame: CGRect.zero)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    setupViews()
  }

  private func setupViews() {
    backgroundColor = .clear
    titleLabel.do {
      self.addSubview($0)
      $0.attributedText = title
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.height(22)
    }

    txtView.do {
      self.addSubview($0)
      $0.height(44)
      $0.topToBottom(of: titleLabel, offset: 5)
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.layer.cornerRadius = 15
      $0.layer.masksToBounds = true
    }

    if showEye {
      eyeButton.do {
        txtView.addSubview($0)
        $0.height(20)
        $0.width(20)
        $0.rightToSuperview(offset: -17)
        $0.centerYToSuperview()
        $0.setImage(R.image.icon_eyes_2(), for: .normal)
        $0.setImage(R.image.icon_eyes_3(), for: .selected)
        $0.addTarget(self, action: #selector(onClickEyeButton(_:)), for: .touchUpInside)
      }
    } else {
      eyeButton.removeFromSuperview()
    }


    txtField.do {
      txtView.addSubview($0)
      $0.topToSuperview(offset: 9.5)
      $0.leftToSuperview(offset: 17)
      if showEye {
        $0.rightToLeft(of: eyeButton, offset: -10)
      } else {
        $0.rightToSuperview(offset: 17)
      }
      $0.bottomToSuperview(offset: -9.5)
      $0.textAlignment = .left
      $0.contentVerticalAlignment = .center
    }

    errorView.do {
      self.addSubview($0)
      $0.height(20)
      $0.topToBottom(of: txtView, offset: 4)
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.bottomToSuperview()
    }

    errorImgView.do {
      errorView.addSubview($0)
      $0.height(14.2)
      $0.width(15.6)
      $0.image = R.image.icon_error_1()
      $0.contentMode = .scaleAspectFit
      $0.leftToSuperview()
      $0.centerYToSuperview()
    }

    errorLabel.do {
      errorView.addSubview($0)
      $0.leftToRight(of: errorImgView, offset: 5)
      $0.centerYToSuperview()
    }

    errorImgView.isHidden = errorString == nil
  }

  @objc
  private func onClickEyeButton(_ sender: UIButton) {
    sender.isSelected = !sender.isSelected
    txtField.isSecureTextEntry = !sender.isSelected
  }
}
