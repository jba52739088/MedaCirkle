//
//  VerifyViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/22.
//

import UIKit
import RxSwift
import RxCocoa

class VerifyViewController: TopGradientViewController {

  var loadingVC: LoadingViewController = LoadingViewController()

  /// 重新傳送驗證碼
  private let titleLabel = UILabel().then { $0.numberOfLines = 0 }
  private let subtitleLabel = UILabel().then { $0.numberOfLines = 0 }
  private lazy var backButton: UIButton = .backButton(target: self, action: #selector(didTapBackButton))
  private lazy var confirmButton: UIButton = .normalSubmitButton(target: self, action: #selector(didTapConfirmButton))
  private let infoLabel = UILabel().then { $0.numberOfLines = 0 }
  private var hintLabel = UILabel()
  private lazy var hintResendLabel: UILabel = .normalActivleLabel(
    tappableText: R.string.localizable.verify_vc_resend_button(),
    originalText: self.viewModel.hintReSendAttributedString,
    tappableColor: .tappableText,
    action: { [weak self] in
      guard let self = self else { return }
      self.didTapReSendButton()
    })


  /// Mail, Phone
  private let verityContainer = UIView()
  private var codeViews: [NumberTextField] = []

  /// PhoneEntry
  private let phoneContainer = UIView()
  private let phoneTextField = TitleTextField(withTitle: false)

  /// Succeed
  private let succeedContainer = UIView()
  private let nameTextField = TitleTextField()
  private let genderTextField = TitleTextField()
  private let birthTextField = BirthTextField()

  let viewModel: VerifyViewModel
  var code: String = ""

  init(_ viewModel: VerifyViewModel) {
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
    switch viewModel.theme.type {
    case .Mail, .Phone:
      setVerifyMailView()
    case .PhoneEntry:
      setVerifyPhoneView()
    case .VerifySucceed:
      setVerifySucceedView()
    }
  }

  private func bindViewModel() {
    var userInfo: String = ""
    let countDown: Int = Int(viewModel.data.cooldown) ?? 0
    if let mailData = viewModel.data as? VerifyMailModel {
      userInfo = mailData.mail
    } else if let phoneData = viewModel.data as? VerifyPhoneModel {
      userInfo = phoneData.phone
    }

    titleLabel.attributedText = viewModel.titleAttributedString
    subtitleLabel.attributedText = viewModel.subtitleAttributedString
    infoLabel.attributedText = viewModel.infoAttributedString(info: userInfo)
    phoneTextField.placeholder = viewModel.phonePlaceholderAttributedString
    nameTextField.title = viewModel.nameAttributedString
    genderTextField.title = viewModel.genderAttributedString
    genderTextField.placeholder = viewModel.genderPlaceholderAttributedString
    birthTextField.title = viewModel.birthAttributedString
    birthTextField.placeholder = viewModel.birthPlaceholderAttributedString
    configHintTimer(second: countDown)

    if (viewModel.theme.type == .Mail ||  viewModel.theme.type == .Phone) && codeViews.count == 5 {
      Observable.combineLatest(codeViews[0].txtField.rx.text.orEmpty,
                               codeViews[1].txtField.rx.text.orEmpty,
                               codeViews[2].txtField.rx.text.orEmpty,
                               codeViews[3].txtField.rx.text.orEmpty,
                               codeViews[4].txtField.rx.text.orEmpty) {
        txt1, txt2, txt3, txt4, txt5 -> Bool in
        if txt1 != "" &&  txt2 != "" &&  txt3 != "" && txt4 != "" && txt5 != "" {
          self.code = txt1 + txt2 + txt3 + txt4 + txt5
          return true
        }
        return false
      }
      .map { $0 }
      .bind(to: confirmButton.rx.isEnabled)
      .disposed(by: disposeBag)
    } else if viewModel.theme.type == .PhoneEntry {
      phoneTextField.txtField.rx.text.orEmpty
      .map { $0 != "" }
      .bind(to: confirmButton.rx.isEnabled)
      .disposed(by: disposeBag)
    }
  }

  private func configHintTimer(second: Int) {
    self.hintLabel.attributedText = self.viewModel.hintAttributedString(info: "05:00")
    self.hintLabel.isHidden = false
    self.hintResendLabel.isHidden = true
    let countdown = second - 1
    Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
      .map { countdown - $0 }
      .takeUntil(.inclusive, predicate: { $0 == 0 })
      .subscribe(onNext: { [weak self] value in
        guard let self = self else { return }
        self.hmsFrom(seconds: value) {  hours, minutes, seconds in
          let second = self.getStringFrom(seconds: seconds)
          let minute = self.getStringFrom(seconds: minutes)
          self.hintLabel.attributedText = self.viewModel.hintAttributedString(info: "\(minute):\(second)")
        }
      }, onCompleted: { [weak self] in
        guard let self = self else { return }
        self.hintLabel.isHidden = true
        self.hintResendLabel.isHidden = false
      }).disposed(by: disposeBag)
  }

}

private extension VerifyViewController {

  func setVerifyMailView() {

    verityContainer.do {
      view.addSubview($0)
      $0.backgroundColor = .clear
      $0.topToSuperview()
      $0.bottomToSuperview()
      $0.leftToSuperview()
      $0.rightToSuperview()
    }

    backButton.do {
      verityContainer.addSubview($0)
      $0.width(30)
      $0.height(30)
      $0.topToSuperview(offset: 10, usingSafeArea: true)
      $0.leftToSuperview(offset: 10, usingSafeArea: true)
    }

    titleLabel.do {
      verityContainer.addSubview($0)
      $0.topToBottom(of: backButton, offset: 12)
      $0.leftToSuperview(offset: 38, usingSafeArea: true)
    }

    subtitleLabel.do {
      verityContainer.addSubview($0)
      $0.topToBottom(of: titleLabel, offset: 10)
      $0.leftToSuperview(offset: 38, usingSafeArea: true)
      $0.rightToSuperview(offset: -38, usingSafeArea: true)
    }

    let mailIcon = UIImageView()
    mailIcon.do {
      verityContainer.addSubview($0)
      $0.image = R.image.icon_share_w25_mail()
      $0.width(25)
      $0.height(25)
      $0.contentMode = .scaleAspectFit
      $0.topToBottom(of: subtitleLabel, offset: 6)
      $0.leftToSuperview(offset: 38, usingSafeArea: true)
    }

    infoLabel.do {
      verityContainer.addSubview($0)
      $0.centerY(to: mailIcon)
      $0.leftToRight(of: mailIcon, offset: 9)
    }

    let verifyCodeView = UIView()
    verifyCodeView.do {
      verityContainer.addSubview($0)
      $0.topToBottom(of: mailIcon, offset: 55)
      $0.height(44)
      $0.centerXToSuperview()
      $0.leftToSuperview(offset: 0, relation: .equalOrGreater)
      $0.rightToSuperview(offset: 0, relation: .equalOrLess)
      self.codeViews = []
      for index in 0 ... 4 {
        let codeView = NumberTextField()
        codeView.tag = index
        $0.addSubview(codeView)
        codeView.topToSuperview()
        codeView.leftToSuperview(offset: index.f * 61.f)
        codeView.rightToSuperview(offset: 0, relation: .equalOrLess)
        codeView.bottomToSuperview()
        self.codeViews.append(codeView)
      }
    }

    hintLabel.do {
      verityContainer.addSubview($0)
      $0.height(24)
      $0.centerXToSuperview()
      $0.topToBottom(of: verifyCodeView, offset: 86)
    }

    hintResendLabel.do {
      verityContainer.addSubview($0)
      $0.height(24)
      $0.centerXToSuperview()
      $0.topToBottom(of: verifyCodeView, offset: 86)
      $0.isHidden = true
    }

    confirmButton.do {
      verityContainer.addSubview($0)
      $0.height(44)
      $0.width(240)
      $0.centerXToSuperview()
      $0.topToBottom(of: hintLabel, offset: 17)
      $0.layer.cornerRadius = 22
      $0.layer.masksToBounds = true
    }
  }

  func setVerifyPhoneView() {

    phoneContainer.do {
      view.addSubview($0)
      $0.backgroundColor = .clear
      $0.topToSuperview()
      $0.bottomToSuperview()
      $0.leftToSuperview()
      $0.rightToSuperview()
    }

    backButton.do {
      phoneContainer.addSubview($0)
      $0.width(30)
      $0.height(30)
      $0.topToSuperview(offset: 10, usingSafeArea: true)
      $0.leftToSuperview(offset: 10, usingSafeArea: true)
    }


    titleLabel.do {
      phoneContainer.addSubview($0)
      $0.topToBottom(of: backButton, offset: 12)
      $0.leftToSuperview(offset: 38, usingSafeArea: true)
    }

    subtitleLabel.do {
      phoneContainer.addSubview($0)
      $0.topToBottom(of: titleLabel, offset: 10)
      $0.leftToSuperview(offset: 38, usingSafeArea: true)
    }

    phoneTextField.do {
      phoneContainer.addSubview($0)
      $0.topToBottom(of: subtitleLabel, offset: 70)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
    }

    confirmButton = .normalSubmitButton(title: R.string.localizable.verify_vc_phone_send_verify_code(),target: self, action: #selector(didTapConfirmButton))

    confirmButton.do {
      phoneContainer.addSubview($0)
      $0.height(44)
      $0.width(240)
      $0.centerXToSuperview()
      $0.topToBottom(of: phoneTextField, offset: 100)
      $0.layer.cornerRadius = 22
      $0.layer.masksToBounds = true
    }
  }

  func setVerifySucceedView() {

    succeedContainer.do {
      view.addSubview($0)
      $0.backgroundColor = .clear
      $0.topToSuperview()
      $0.bottomToSuperview()
      $0.leftToSuperview()
      $0.rightToSuperview()
    }

    backButton.do {
      succeedContainer.addSubview($0)
      $0.width(30)
      $0.height(30)
      $0.topToSuperview(offset: 10, usingSafeArea: true)
      $0.leftToSuperview(offset: 10, usingSafeArea: true)
    }

    titleLabel.do {
      succeedContainer.addSubview($0)
      $0.topToBottom(of: backButton, offset: 12)
      $0.leftToSuperview(offset: 38, usingSafeArea: true)
    }

    subtitleLabel.do {
      succeedContainer.addSubview($0)
      $0.topToBottom(of: titleLabel, offset: 2)
      $0.leftToSuperview(offset: 38, usingSafeArea: true)
      $0.rightToSuperview(offset: -38, usingSafeArea: true)
    }

    nameTextField.do {
      succeedContainer.addSubview($0)
      $0.topToBottom(of: subtitleLabel, offset: 40)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
    }

    genderTextField.do {
      succeedContainer.addSubview($0)
      $0.topToBottom(of: nameTextField, offset: 1)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
    }

    birthTextField.do {
      succeedContainer.addSubview($0)
      $0.topToBottom(of: genderTextField, offset: 1)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
    }


  }

  @objc
  private func didTapBackButton() {
    print("didTapBackButton")
    sceneCoordinator.dismiss(animated: false, completion: nil)
  }

  @objc
  private func didTapConfirmButton() {
    print("didTapConfirmButton")

    if viewModel.theme.type == .Mail,
       let data = viewModel.data as? VerifyMailModel {
      self.showLoading()
      MainAppService.shared
        .userSessionRequestManager
        .registerVerifyMail(token: data.token, code: self.code)
        .observe(on: MainScheduler.instance)
        .do(onSuccess: ({ [weak self] reponseData in
          self?.hideLoading(completion: {
            let token = reponseData?.token ?? ""
            let cooldown = reponseData?.cooldown ?? ""
            let vm = VerifyViewModel(data: VerifyModel(token: token, cooldown: cooldown),
                                     theme: VerifyViewModel.Theme(pageType: .PhoneEntry))
            sceneCoordinator.transit(to: Scene.verify(vm), by: .overFullScreen, completion: nil)
          })
        }), onError: ({ [weak self] error in
          self?.hideLoading()
          print("error: \(error)")
        }))
        .subscribe()
        .disposed(by: disposeBag)
    } else if viewModel.theme.type == .PhoneEntry {
      self.showLoading()
      let userPhone = self.phoneTextField.txtField.text ?? ""
      MainAppService.shared
        .userSessionRequestManager
        .registerSendSMS(mobile: userPhone, token: viewModel.data.token)
        .observe(on: MainScheduler.instance)
        .do(onSuccess: ({ [weak self] reponseData in
          self?.hideLoading(completion: {
            let token = reponseData?.token ?? ""
            let cooldown = reponseData?.cooldown ?? ""
            let vm = VerifyViewModel(data: VerifyPhoneModel(phone: userPhone, token: token, cooldown: cooldown),
                                     theme: VerifyViewModel.Theme(pageType: .Phone))
            sceneCoordinator.transit(to: Scene.verify(vm), by: .overFullScreen, completion: nil)
          })
        }), onError: ({ [weak self] error in
          self?.hideLoading()
          print("error: \(error)")
        }))
        .subscribe()
        .disposed(by: disposeBag)
    } else if viewModel.theme.type == .Phone,
              let data = viewModel.data as? VerifyPhoneModel {
      self.showLoading()
      MainAppService.shared
        .userSessionRequestManager
        .registerVerifyPhone(token: data.token, code: self.code)
        .observe(on: MainScheduler.instance)
        .do(onSuccess: ({ [weak self] reponseData in
          self?.hideLoading(completion: {
            let token = reponseData?.token ?? ""
            let cooldown = reponseData?.cooldown ?? ""
            let vm = VerifyViewModel(data: VerifyModel(token: token, cooldown: cooldown),
                                     theme: VerifyViewModel.Theme(pageType: .VerifySucceed))
            sceneCoordinator.transit(to: Scene.verify(vm), by: .overFullScreen, completion: nil)
          })
        }), onError: ({ [weak self] error in
          self?.hideLoading()
          print("error: \(error)")
        }))
        .subscribe()
        .disposed(by: disposeBag)
      }
//    sceneCoordinator.transit(to: .resetPassword, by: .overFullScreen, completion: nil)
  }

  @objc
  private func didTapReSendButton() {
    print("didTapReSendButton")
    if viewModel.theme.type == .Mail,
       let data = viewModel.data as? VerifyMailModel {
      self.showLoading()
      MainAppService.shared
        .userSessionRequestManager
        .registerReSendMail(token: data.token)
        .observe(on: MainScheduler.instance)
        .do(onSuccess: ({ [weak self] reponseData in
          self?.hideLoading(completion: {
            self?.viewModel.data.token = reponseData?.token ?? ""
            let cooldown = reponseData?.cooldown ?? ""
            let second = Int(cooldown) ?? 0
            self?.configHintTimer(second: second)
          })
        }), onError: ({ [weak self] error in
          self?.hideLoading()
          print("error: \(error)")
        }))
        .subscribe()
        .disposed(by: disposeBag)
    }
//    self.confirmButton.isEnabled = true
  }

  /// time formate
  private func hmsFrom(seconds: Int, completion: @escaping (_ hours: Int, _ minutes: Int, _ seconds: Int)->()) {
    completion(seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
  }

  private func getStringFrom(seconds: Int) -> String {
    return seconds < 10 ? "0\(seconds)" : "\(seconds)"
  }
}

//MARK: FullScreenLoadingPresenting
extension VerifyViewController: FullScreenLoadingPresenting { }
