//
//  ForgetPwdViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/26.
//

import UIKit
import RxSwift
import RxCocoa


class ForgetPwdViewController: TopGradientViewController {

  private lazy var backButton: UIButton = .backButton(target: self, action: #selector(didTapBackButton))
  private let titleLabel = UILabel().then { $0.numberOfLines = 0 }
  private let subtitleLabel = UILabel().then { $0.numberOfLines = 0 }
  private let phoneTextField = TitleTextField()
  private let birthTextField = BirthTextField()
  private lazy var submitButton: UIButton = .normalSubmitButton(title: R.string.localizable.forgetPwd_vc_submit(),
                                                                target: self,
                                                                action: #selector(didTapSubmitButton))

  let viewModel: ForgetPwdViewModel

  init(_ viewModel: ForgetPwdViewModel) {
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
    backButton.do {
      view.addSubview($0)
      $0.width(30)
      $0.height(30)
      $0.topToSuperview(offset: 10, usingSafeArea: true)
      $0.leftToSuperview(offset: 10, usingSafeArea: true)
    }

    titleLabel.do {
      view.addSubview($0)
      $0.topToBottom(of: backButton, offset: 12)
      $0.leftToSuperview(offset: 38, usingSafeArea: true)
    }

    subtitleLabel.do {
      view.addSubview($0)
      $0.topToBottom(of: titleLabel, offset: 10)
      $0.leftToSuperview(offset: 38, usingSafeArea: true)
      $0.rightToSuperview(offset: -38, usingSafeArea: true)
    }

    phoneTextField.do {
      view.addSubview($0)
      $0.topToBottom(of: subtitleLabel, offset: 50)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
    }

    birthTextField.do {
      view.addSubview($0)
      $0.topToBottom(of: phoneTextField, offset: -4)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
    }

    submitButton.do {
      view.addSubview($0)
      $0.height(44)
      $0.width(240)
      $0.centerXToSuperview()
      $0.topToBottom(of: birthTextField, offset: 25)
      $0.layer.cornerRadius = 22
      $0.layer.masksToBounds = true
    }

  }

  private func bindViewModel() {
    titleLabel.attributedText = viewModel.titleAttributedString
    subtitleLabel.attributedText = viewModel.subtitleAttributedString
    phoneTextField.title = viewModel.phoneAttributedString
    phoneTextField.placeholder = viewModel.phonePlaceholderAttributedString
    birthTextField.title = viewModel.birthAttributedString
    birthTextField.placeholder = viewModel.birthPlaceholderAttributedString
  }
}

private
extension ForgetPwdViewController {

  @objc func didTapBackButton() {
    print("didTapBackButton")
  }


  @objc func didTapSubmitButton() {
    print("didTapSubmitButton")
  }

}
