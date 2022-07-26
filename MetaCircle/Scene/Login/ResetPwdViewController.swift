//
//  ResetPwdViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/28.
//

import UIKit
import RxSwift
import RxCocoa


class ResetPwdViewController: TopGradientViewController {

  private lazy var backButton: UIButton = .backButton(target: self, action: #selector(didTapBackButton))
  private let titleLabel = UILabel().then { $0.numberOfLines = 0 }
  private let hintImage = UIImageView().then {
    $0.image = R.image.icon_success_h30()
    $0.contentMode = .scaleAspectFit
  }
  private let subtitleLabel = UILabel().then { $0.numberOfLines = 0 }
  private let pwdTextField = TitleTextField().then { $0.showEye = true }
  private let rePwdTextField = TitleTextField().then { $0.showEye = true }
  private lazy var submitButton: UIButton = .normalSubmitButton(title: R.string.localizable.resetPwd_vc_re_submit_button(),
                                                                target: self,
                                                                action: #selector(didTapSubmitButton))

  let viewModel: ResetPwdViewModel

  init(_ viewModel: ResetPwdViewModel = ResetPwdViewModel()) {
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

    hintImage.do {
      view.addSubview($0)
      $0.width(30)
      $0.height(30)
      $0.topToBottom(of: backButton, offset: 28)
      $0.leftToSuperview(offset: 38, usingSafeArea: true)
    }

    subtitleLabel.do {
      view.addSubview($0)
      $0.centerY(to: hintImage)
      $0.leftToRight(of: hintImage, offset: 8)
    }

    titleLabel.do {
      view.addSubview($0)
      $0.topToBottom(of: hintImage, offset: 9)
      $0.leftToSuperview(offset: 38, usingSafeArea: true)
    }

    pwdTextField.do {
      view.addSubview($0)
      $0.topToBottom(of: titleLabel, offset: 47)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
    }

    rePwdTextField.do {
      view.addSubview($0)
      $0.topToBottom(of: pwdTextField, offset: 15)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
    }

    submitButton.do {
      view.addSubview($0)
      $0.height(44)
      $0.width(240)
      $0.centerXToSuperview()
      $0.topToBottom(of: rePwdTextField, offset: 67)
      $0.layer.cornerRadius = 22
      $0.layer.masksToBounds = true
    }

  }

  private func bindViewModel() {
    titleLabel.attributedText = viewModel.titleAttributedString
    subtitleLabel.attributedText = viewModel.subtitleAttributedString
    pwdTextField.title = viewModel.pwdAttributedString
    pwdTextField.placeholder = viewModel.pwdPlaceholderAttributedString
    pwdTextField.hintString = viewModel.pwdHintAttributedString
    rePwdTextField.placeholder = viewModel.rePwdPlaceholderAttributedString

    pwdTextField.txtField.txtField.rx.controlEvent(.editingDidBegin)
      .asObservable()
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        self.submitButton.isEnabled = true
      })
      .disposed(by: disposeBag)
  }
}

private
extension ResetPwdViewController {

  @objc func didTapBackButton() {
    print("didTapBackButton")
  }


  @objc func didTapSubmitButton() {
    print("didTapSubmitButton")
    sceneCoordinator.transit(to: .login, by: .root, completion: nil)
  }

}

