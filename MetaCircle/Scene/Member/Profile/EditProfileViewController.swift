//
//  EditProfileViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/14.
//

import UIKit
import TinyConstraints
import RxSwift
import RxCocoa
import RxGesture

class EditProfileViewController: BaseViewController {

  private let topView = UIView().then {
    $0.backgroundColor = .clear
  }
  private lazy var backButton: UIButton = .closeButton(target: self, action: #selector(didTapCloseButton))
//  private let addBtn = UIButton(type: .custom)
  private let titleLabel = UILabel()
  private let scrollView = UIScrollView().then {
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
  private let infoTitleLabel = UILabel()
  let nicknameTextField = NormalTextField()
  let nameTextField = NormalTextField()
  private lazy var namePublicSwitch: UIButton = .titleSwitchButton(target: self, action: #selector(didTapSwitch(_:)))
  let genderTextField = NormalTextField()
  private lazy var genderPublicSwitch: UIButton = .titleSwitchButton(target: self, action: #selector(didTapSwitch(_:)))
  private let birthTextField = BirthTextField(withTitle: true)
  private let birthHintLabel = UILabel().then {
    $0.numberOfLines = 0
  }
  private lazy var birthPublicSwitch: UIButton = .titleSwitchButton(target: self, action: #selector(didTapSwitch(_:)))
  private let introTitleLabel = UILabel()
  let textView = UIPlaceholderTextView().then {
    $0.backgroundColor = .textFieldNormalBg
    $0.textContainerInset = UIEdgeInsets(top: 13, left: 22, bottom: 13, right: 22)
    $0.placeholder = R.string.localizable.profile_edit_intro_placeHolder()
  }
  private lazy var confirmButton: UIButton = .normalConfirmButton(title: R.string.localizable.profile_edit_save(), target: self, action:  #selector(didTapConfirmButton))
  private lazy var resetButton: UIButton = .normalCancelButton(title: R.string.localizable.profile_edit_reset(), target: self, action:  #selector(didTapResetButton))
  
  let viewModel: EditProfileViewModel

  init(_ viewModel: EditProfileViewModel = EditProfileViewModel()) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    disposeBag = DisposeBag()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    configView()
    bindViewModel()
  }

  private func configView() {
    view.backgroundColor = .normalLightBg
    topView.do {
      view.addSubview($0)
      $0.height(50)
      $0.topToSuperview(usingSafeArea: true)
      $0.leftToSuperview()
      $0.rightToSuperview()
    }

    backButton.do {
      topView.addSubview($0)
      $0.width(30)
      $0.height(30)
      $0.rightToSuperview(offset: -10, usingSafeArea: true)
      $0.centerYToSuperview()
    }

    titleLabel.do {
      topView.addSubview($0)
      $0.centerYToSuperview()
      $0.centerXToSuperview()
    }

    scrollView.do {
      view.addSubview($0)
      $0.topToBottom(of: topView)
      $0.leftToSuperview()
      $0.bottomToSuperview()
      $0.rightToSuperview()
    }

    let contentView = UIView()
    contentView.do {
      scrollView.addSubview($0)
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.bottomToSuperview()
      $0.rightToSuperview()
      $0.width(UIScreen.main.bounds.width)
    }

    infoTitleLabel.do {
      contentView.addSubview($0)
      $0.topToSuperview(offset: 36)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
    }

    nicknameTextField.do {
      contentView.addSubview($0)
      $0.topToBottom(of: infoTitleLabel, offset: 32)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
    }

    nameTextField.do {
      contentView.addSubview($0)
      $0.topToBottom(of: nicknameTextField, offset: 40)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
    }

    namePublicSwitch.do {
      contentView.addSubview($0)
      $0.topToBottom(of: nameTextField, offset: 8)
      $0.trailingToSuperview(offset: 38)
    }

    genderTextField.do {
      contentView.addSubview($0)
      $0.topToBottom(of: namePublicSwitch, offset: 40)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
    }

    genderPublicSwitch.do {
      contentView.addSubview($0)
      $0.topToBottom(of: genderTextField, offset: 8)
      $0.trailingToSuperview(offset: 38)
    }

    birthTextField.do {
      contentView.addSubview($0)
      $0.topToBottom(of: genderPublicSwitch, offset: 38)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
    }

    birthHintLabel.do {
      contentView.addSubview($0)
      $0.topToBottom(of: birthTextField, offset: 5)
      $0.leadingToSuperview(offset: 48)
      $0.trailingToSuperview(offset: 48)
    }

    birthPublicSwitch.do {
      contentView.addSubview($0)
      $0.topToBottom(of: birthHintLabel, offset: 0)
      $0.trailingToSuperview(offset: 38)
    }

    introTitleLabel.do {
      contentView.addSubview($0)
      $0.topToBottom(of: birthPublicSwitch, offset: 40)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
    }

    textView.do {
      contentView.addSubview($0)
      $0.topToBottom(of: introTitleLabel, offset: 26)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
      $0.height(144)
      $0.layer.cornerRadius = 15
      $0.layer.masksToBounds = true
    }

    let buttonView = UIView()
    buttonView.do {
      contentView.addSubview($0)
      $0.topToBottom(of: textView, offset: 60)
      $0.leadingToSuperview(offset: 60)
      $0.trailingToSuperview(offset: 60)
      $0.height(44)
      $0.bottomToSuperview(offset: -18, usingSafeArea: true)
    }

    resetButton.do {
      buttonView.addSubview($0)
      $0.topToSuperview()
      $0.bottomToSuperview()
      $0.leadingToSuperview()
      $0.layer.cornerRadius = 22
      $0.layer.masksToBounds = true
      $0.layer.borderWidth = 1.f
      $0.layer.borderColor = UIColor.tappableText.cgColor
    }

    confirmButton.do {
      buttonView.addSubview($0)
      $0.topToSuperview()
      $0.bottomToSuperview()
      $0.trailingToSuperview()
      $0.width(to: resetButton)
      $0.leftToRight(of: resetButton, offset: 15)
      $0.layer.cornerRadius = 22
      $0.layer.masksToBounds = true
    }
  }


  private func bindViewModel() {
    titleLabel.attributedText = viewModel.titleAttributedString
    infoTitleLabel.attributedText = viewModel.infoTitleAttributedString
    nicknameTextField.title = viewModel.nicknameTitleAttributedString
    nicknameTextField.placeholder = viewModel.nicknamePlacehodlerAttributedString
    nameTextField.title = viewModel.nameTitleAttributedString
    nameTextField.placeholder = viewModel.namePlacehodlerAttributedString
    genderTextField.title = viewModel.genderTitleAttributedString
    birthTextField.title = viewModel.birthTitleAttributedString
    birthTextField.placeholder = viewModel.birthPlaceholderAttributedString
    birthHintLabel.attributedText = viewModel.birthHintAttributedString
    introTitleLabel.attributedText = viewModel.introTitleAttributedString
    textView.placeholder = R.string.localizable.profile_edit_intro_placeHolder()
  }

  @objc
  private func didTapCloseButton() {
    sceneCoordinator.dismiss(animated: true, completion: nil)
  }

  @objc
  private func didTapSwitch(_ sender: UIButton) {
    sender.isSelected = !sender.isSelected
  }

  @objc func didTapConfirmButton() {
    print("didTapConfirmButton")
    
  }

  @objc func didTapResetButton() {
    print("didTapResetButton")

  }
}
