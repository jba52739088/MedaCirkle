//
//  EditWebSiteViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/20.
//

import UIKit
import TinyConstraints
import RxSwift
import RxCocoa
import RxGesture

class EditWebSiteViewController: BaseViewController {

  private let topView = UIView().then {
    $0.backgroundColor = .clear
  }
  private lazy var backButton: UIButton = .closeButton(target: self, action: #selector(didTapCloseButton))
//  private let addBtn = UIButton(type: .custom)
  private let titleLabel = UILabel()
  private let scrollView = UIScrollView().then {
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
  let webTextField = NormalTextField()
  let urlTextField = NormalTextField()

  private lazy var confirmButton: UIButton = .normalSubmitButton(title: R.string.localizable.profile_edit_save(), target: self, action:  #selector(didTapConfirmButton))
  private lazy var resetButton: UIButton = .normalSubmitButton(title: R.string.localizable.profile_edit_reset(), target: self, action:  #selector(didTapResetButton))

  let viewModel: EditWebSiteViewModel

  init(_ viewModel: EditWebSiteViewModel = EditWebSiteViewModel()) {
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

    webTextField.do {
      view.addSubview($0)
      $0.topToBottom(of: topView, offset: 52)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
    }

    urlTextField.do {
      view.addSubview($0)
      $0.topToBottom(of: webTextField, offset: 24)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
    }

    let buttonView = UIView()
    buttonView.do {
      view.addSubview($0)
      $0.leadingToSuperview(offset: 60)
      $0.trailingToSuperview(offset: 60)
      $0.height(44)
      $0.bottomToSuperview(offset: -8, usingSafeArea: true)
    }

    resetButton.do {
      buttonView.addSubview($0)
      $0.topToSuperview()
      $0.bottomToSuperview()
      $0.leadingToSuperview()
      $0.layer.cornerRadius = 22
      $0.layer.masksToBounds = true
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
    webTextField.title = viewModel.webTitleAttributedString
    webTextField.placeholder = viewModel.webPlacehodlerAttributedString
    urlTextField.title = viewModel.urlTitleAttributedString
    urlTextField.placeholder = viewModel.urlPlacehodlerAttributedString
  }

  @objc
  private func didTapCloseButton() {
    sceneCoordinator.dismiss(animated: true, completion: nil)
  }

  @objc func didTapConfirmButton() {
    print("didTapConfirmButton")

  }

  @objc func didTapResetButton() {
    print("didTapResetButton")

  }
}

