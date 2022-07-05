//
//  LoginViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/18.
//

import UIKit
import TinyConstraints
import RxSwift

class LoginViewController: TopGradientViewController {

  var loadingVC: LoadingViewController = LoadingViewController()

  private let backButton = UIButton().then {
    $0.setImage(R.image.icon_arrow_left_w10_h16(), for: .normal)
    $0.imageEdgeInsets = UIEdgeInsets(top: 8.53, left: 0, bottom: 8.53, right: 0)
    $0.imageView?.contentMode = .scaleAspectFit
  }

  private lazy var loginLabel: UILabel = {
    return .normalActivleLabel(
      tappableText: R.string.localizable.login_vc_register_button(),
      originalText: viewModel.registerAttributedString,
      tappableColor: .tappableText,
      action: { [weak self] in
        guard let this = self else { return }
        this.didTapRegister()
      })
  }()

  private let titleLabel = UILabel().then {
    $0.textAlignment = .left
  }

  private let subtitleLabel = UILabel().then {
    $0.textAlignment = .left
  }

  private let facebookBtn = UIButton().then {
    $0.setImage(R.image.icon_social_media_facebook(), for: .normal)
    $0.backgroundColor = .btnFacebook
    $0.layer.cornerRadius = 22
    $0.layer.masksToBounds = true
    $0.titleLabel?.textAlignment = .center
    $0.contentMode = .center
    $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
  }
  private let twitterBtn = UIButton().then {
    $0.setImage(R.image.icon_social_media_twitter(), for: .normal)
    $0.backgroundColor = .btnTwitter
    $0.layer.cornerRadius = 22
    $0.layer.masksToBounds = true
    $0.titleLabel?.textAlignment = .center
    $0.contentMode = .center
    $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
  }
  private let googleBtn = UIButton().then {
    $0.setImage(R.image.icon_social_media_google(), for: .normal)
    $0.backgroundColor = .white
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.borderWhiteBtn.cgColor
    $0.layer.cornerRadius = 22
    $0.layer.masksToBounds = true
    $0.titleLabel?.textAlignment = .center
    $0.contentMode = .center
    $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10.93, bottom: 0, right: -10.93)
  }

  private let horizontalLine = UIView().then {
    $0.backgroundColor = .borderWhiteBtn
  }

  private let midLabel = UILabel().then {
    $0.textAlignment = .center
  }

  private let mailTxtField = TitleTextField()
  private let pwdTxtField = TitleTextField()
  private let forgetButton = UIButton(type: .custom)
  private let loginButton = UIButton(type: .custom)

  var viewModel: LoginViewModel

  init(_ viewModel: LoginViewModel = LoginViewModel()) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    configView()
    bindViewModel()
  }

  deinit {
    disposeBag = DisposeBag()
  }

  private func configView() {

    backButton.do {
      view.addSubview($0)
      $0.width(30)
      $0.height(30)
      $0.topToSuperview(offset: 10, usingSafeArea: true)
      $0.leftToSuperview(offset: 10, usingSafeArea: true)
      $0.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }

    loginLabel.do {
      view.addSubview($0)
      $0.rightToSuperview(offset: -15, usingSafeArea: true)
      $0.centerY(to: backButton)
    }

    titleLabel.do {
      view.addSubview($0)
      $0.height(36)
      $0.topToBottom(of: backButton, offset: 12)
      $0.leadingToSuperview(offset: 38)
    }

    subtitleLabel.do {
      view.addSubview($0)
      $0.height(41)
      $0.topToBottom(of: titleLabel, offset: 2)
      $0.leadingToSuperview(offset: 38)
    }

    facebookBtn.do {
      view.addSubview($0)
      $0.height(44)
      $0.topToBottom(of: subtitleLabel, offset: 13)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
      $0.addTarget(self, action: #selector(didTapFacebookLogin), for: .touchUpInside)
    }

    twitterBtn.do {
      view.addSubview($0)
      $0.height(44)
      $0.topToBottom(of: facebookBtn, offset: 10)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
      $0.addTarget(self, action: #selector(didTapTwitterLogin), for: .touchUpInside)
    }

    googleBtn.do {
      view.addSubview($0)
      $0.height(44)
      $0.topToBottom(of: twitterBtn, offset: 10)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
      $0.addTarget(self, action: #selector(didTapFacebookLogin), for: .touchUpInside)
    }

    let midView = UIView()
    midView.do {
      view.addSubview($0)
      $0.width(75)
      $0.height(75)
      $0.centerXToSuperview()
      $0.topToBottom(of: googleBtn, offset: 0)
      $0.backgroundColor = .white
    }

    midLabel.do {
      midView.addSubview($0)
      $0.centerXToSuperview()
      $0.centerYToSuperview()
    }

    horizontalLine.do {
      view.addSubview($0)
      $0.height(1)
      $0.centerY(to: midView)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
      view.sendSubviewToBack($0)
    }

    mailTxtField.do {
      view.addSubview($0)
      $0.topToBottom(of: midView)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
    }

    pwdTxtField.do {
      view.addSubview($0)
      $0.showEye = true
      $0.topToBottom(of: mailTxtField, offset: 1)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
    }

    forgetButton.do {
      view.addSubview($0)
      $0.topToBottom(of: pwdTxtField, offset: 20)
      $0.centerXToSuperview()
      $0.addTarget(self, action: #selector(didTapForgotPwd), for: .touchUpInside)
    }

    loginButton.do {
      view.addSubview($0)
      $0.width(240)
      $0.height(44)
      $0.backgroundColor = .btnGray
      $0.topToBottom(of: forgetButton, offset: 35.5)
      $0.centerXToSuperview()
      $0.layer.cornerRadius = 22
      $0.layer.masksToBounds = true
      $0.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }

  }

  private func bindViewModel() {
    titleLabel.attributedText = viewModel.titleAttributedString
    subtitleLabel.attributedText = viewModel.subtitleAttributedString
    facebookBtn.setAttributedTitle(viewModel.facebookAttributedString, for: .normal)
    twitterBtn.setAttributedTitle(viewModel.twitterAttributedString, for: .normal)
    googleBtn.setAttributedTitle(viewModel.googleAttributedString, for: .normal)
    midLabel.attributedText = viewModel.midAttributedString
    mailTxtField.title = viewModel.emailAttributedString
    mailTxtField.placeholder = viewModel.emailPlaceholderAttributedString
    pwdTxtField.title = viewModel.passwordAttributedString
    pwdTxtField.placeholder = viewModel.passwordPlaceholderAttributedString
    pwdTxtField.errorString = viewModel.errorAttributedString(error: "不是有效的電子郵件")
    pwdTxtField.txtField.isSecureTextEntry = true
    forgetButton.setAttributedTitle(viewModel.forgetPwdAttributedString, for: .normal)
    loginButton.setAttributedTitle(viewModel.enableLoginAttributedString, for: .normal)
    loginButton.setAttributedTitle(viewModel.disableLoginAttributedString, for: .disabled)
//    loginButton.isEnabled = false
  }

  @objc
  private func didTapBackButton() {
    print("didTapBackButton")
    sceneCoordinator.transit(to: .home, by: .root, completion: nil)
  }

  @objc
  private func didTapRegister() {
    print("didTapRegister")
    sceneCoordinator.transit(to: .register, by: .overFullScreen, completion: nil)
  }

  @objc
  private func didTapFacebookLogin() {
    print("didTapFacebookLogin")
  }

  @objc
  private func didTapTwitterLogin() {
    print("didTapTwitterLogin")
  }

  @objc
  private func didTapGoogleLogin() {
    print("didTapGoogleLogin")
  }

  @objc
  private func didTapForgotPwd() {
    sceneCoordinator.transit(to: .forgetPassword, by: .overFullScreen, completion: nil)
  }

  @objc
  private func didTapLogin() {
    print("didTapLogin")

    showLoading()
    self.doLogin(mail: "jba52739088@gmail.com", password: "qwerty123")
  }
}

//MARK: FullScreenLoadingPresenting
extension LoginViewController: FullScreenLoadingPresenting { }

//MARK: LoginRouting
extension LoginViewController: LoginRouting {

  func loginSucceed(in vc: UIViewController) {
    self.hideLoading {
      sceneCoordinator.transit(to: .home, by: .root) {
        MainAppService.shared.registerCompletedRelay.accept(())
      }
    }
  }

  func loginFailed(in vc: UIViewController, errorCode: String?, errorMessage: String?) {
    self.hideLoading()
  }
}
