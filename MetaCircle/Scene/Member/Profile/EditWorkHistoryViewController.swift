//
//  EditWorkHistoryViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/27.
//

import UIKit
import TinyConstraints
import RxSwift
import RxCocoa
import RxGesture

class EditWorkHistoryViewController: BaseViewController {

  private let topView = UIView().then {
    $0.backgroundColor = .clear
  }
  private lazy var backButton: UIButton = .closeButton(target: self, action: #selector(didTapCloseButton))
//  private let addBtn = UIButton(type: .custom)
  private let titleLabel = UILabel()
  private let scrollView = UIScrollView().then {
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
  private let hintTitleLabel = UILabel()
  let companyTextField = NormalTextField()
  let positionTextField = MetaTextField()
  let locationTextField = MetaTextField()
  let dateStartTextField = BirthTextField(withTitle: true)
  private let stillButton = UIButton(type: .custom).then {
    $0.setImage(R.image.checkbox(), for: .normal)
    $0.setImage(R.image.checkbox_selected(), for: .selected)
    $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 9)
    $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 9, bottom: 0, right: -9)
    $0.height(25)
  }
  private let detailTitleLabel = UILabel()
  let textView = UIPlaceholderTextView().then {
    $0.backgroundColor = .textFieldNormalBg
    $0.textContainerInset = UIEdgeInsets(top: 13, left: 22, bottom: 13, right: 22)
    $0.placeholder = R.string.localizable.profile_edit_intro_placeHolder()
  }
  private lazy var confirmButton: UIButton = .normalConfirmButton(title: R.string.localizable.profile_edit_save(), target: self, action:  #selector(didTapConfirmButton))
  private lazy var resetButton: UIButton = .normalConfirmButton(title: R.string.localizable.profile_edit_reset(), target: self, action:  #selector(didTapResetButton))

  let viewModel: EditWorkHistoryViewModel

  init(_ viewModel: EditWorkHistoryViewModel = EditWorkHistoryViewModel()) {
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
      $0.leftToSuperview(offset: 38)
      $0.bottomToSuperview()
      $0.rightToSuperview(offset: -37)
      $0.showsVerticalScrollIndicator = false
    }

    let contentView = UIView()
    contentView.do {
      scrollView.addSubview($0)
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.bottomToSuperview()
      $0.rightToSuperview()
      $0.width(to: scrollView)
    }

    hintTitleLabel.do {
      contentView.addSubview($0)
      $0.topToSuperview(offset: 30)
      $0.leadingToSuperview()
      $0.trailingToSuperview()
      $0.numberOfLines = 0
    }

    companyTextField.do {
      contentView.addSubview($0)
      $0.topToBottom(of: hintTitleLabel, offset: 35)
      $0.leadingToSuperview()
      $0.trailingToSuperview()
    }

    positionTextField.do {
      contentView.addSubview($0)
      $0.topToBottom(of: companyTextField, offset: 10)
      $0.leadingToSuperview()
      $0.trailingToSuperview()
    }

    locationTextField.do {
      contentView.addSubview($0)
      $0.topToBottom(of: positionTextField, offset: 10)
      $0.leadingToSuperview()
      $0.trailingToSuperview()
    }

    dateStartTextField.do {
      contentView.addSubview($0)
      $0.topToBottom(of: locationTextField, offset: 44)
      $0.leadingToSuperview()
      $0.trailingToSuperview()
    }

    stillButton.do {
      contentView.addSubview($0)
      $0.topToBottom(of: dateStartTextField, offset: 10)
      $0.leftToSuperview()
      $0.rightToSuperview(relation: .equalOrLess)
      $0.height(25)
    }

    detailTitleLabel.do {
      contentView.addSubview($0)
      $0.topToBottom(of: stillButton, offset: 44)
      $0.leadingToSuperview()
      $0.trailingToSuperview()
    }

    textView.do {
      contentView.addSubview($0)
      $0.topToBottom(of: detailTitleLabel, offset: 10)
      $0.leadingToSuperview()
      $0.trailingToSuperview()
      $0.height(144)
      $0.isScrollEnabled = false
      $0.layer.cornerRadius = 15
      $0.layer.masksToBounds = true
    }

    let buttonView = UIView()
    buttonView.do {
      contentView.addSubview($0)
      $0.topToBottom(of: textView, offset: 60)
      $0.leadingToSuperview(offset: 23)
      $0.trailingToSuperview(offset: 23)
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
    hintTitleLabel.attributedText = viewModel.hintAttributedString
    companyTextField.title = viewModel.postitonTitleAttributedString
    companyTextField.placeholder = viewModel.cpmpanyPlacehodlerAttributedString
    positionTextField.placeholder = viewModel.positionPlacehodlerAttributedString
    locationTextField.placeholder = viewModel.locationPlacehodlerAttributedString
    dateStartTextField.title = viewModel.durationTitleAttributedString
    dateStartTextField.placeholder = viewModel.datePlacehodlerAttributedString
    stillButton.setAttributedTitle(viewModel.stillDoingAttributedString, for: .normal)
    detailTitleLabel.attributedText = viewModel.introTitleAttributedString
    textView.placeholder = R.string.localizable.profile_edit_education_intro_placeholder()
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


