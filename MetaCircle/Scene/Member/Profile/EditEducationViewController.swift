//
//  EditEducationViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/21.
//

import UIKit
import TinyConstraints
import RxSwift
import RxCocoa
import RxGesture

class EditEducationViewController: BaseViewController {

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
  private let infoTitleLabel = UILabel()
  let levelTextField = NormalTextField()
  let nameTextField = MetaTextField()
  private let dateTitleLabel = UILabel()
  let dateStartTextField = BirthTextField()
  let dateEndTextField = BirthTextField()
  private let statusTitleLabel = UILabel()
  private let graduatedButton = UIButton(type: .custom).then {
    let studyStatus = EditEducationViewModel.StudyStatus.graduated
    $0.tag = studyStatus.tag
    $0.setAttributedTitle(studyStatus.titleAttributedString, for: .normal)
    $0.setImage(R.image.radio_button_1(), for: .normal)
    $0.setImage(R.image.radio_button_1_selected(), for: .selected)
    $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
    $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: -5)
    $0.height(25)
  }
  private let noncompletionButton = UIButton(type: .custom).then {
    let studyStatus = EditEducationViewModel.StudyStatus.noncompletion
    $0.tag = studyStatus.tag
    $0.setAttributedTitle(studyStatus.titleAttributedString, for: .normal)
    $0.setImage(R.image.radio_button_1(), for: .normal)
    $0.setImage(R.image.radio_button_1_selected(), for: .selected)
    $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
    $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: -5)
    $0.height(25)
  }
  private let studyingButton = UIButton(type: .custom).then {
    let studyStatus = EditEducationViewModel.StudyStatus.studying
    $0.tag = studyStatus.tag
    $0.setAttributedTitle(studyStatus.titleAttributedString, for: .normal)
    $0.setImage(R.image.radio_button_1(), for: .normal)
    $0.setImage(R.image.radio_button_1_selected(), for: .selected)
    $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
    $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: -5)
    $0.height(25)
  }
  let majorTextField = NormalTextField()
  private let detailTitleLabel = UILabel()
  let textView = UIPlaceholderTextView().then {
    $0.backgroundColor = .textFieldNormalBg
    $0.textContainerInset = UIEdgeInsets(top: 13, left: 22, bottom: 13, right: 22)
    $0.placeholder = R.string.localizable.profile_edit_intro_placeHolder()
  }
  private lazy var confirmButton: UIButton = .normalConfirmButton(title: R.string.localizable.profile_edit_save(), target: self, action:  #selector(didTapConfirmButton))
  private lazy var resetButton: UIButton = .normalConfirmButton(title: R.string.localizable.profile_edit_reset(), target: self, action:  #selector(didTapResetButton))

  let viewModel: EditEducationViewModel

  init(_ viewModel: EditEducationViewModel = EditEducationViewModel()) {
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

    infoTitleLabel.do {
      contentView.addSubview($0)
      $0.topToBottom(of: hintTitleLabel, offset: 35)
      $0.leadingToSuperview()
      $0.trailingToSuperview()
    }

    levelTextField.do {
      contentView.addSubview($0)
      $0.topToBottom(of: infoTitleLabel, offset: 10)
      $0.leadingToSuperview()
      $0.trailingToSuperview()
    }

    nameTextField.do {
      contentView.addSubview($0)
      $0.topToBottom(of: levelTextField, offset: 10)
      $0.leadingToSuperview()
      $0.trailingToSuperview()
    }

    dateTitleLabel.do {
      contentView.addSubview($0)
      $0.topToBottom(of: nameTextField, offset: 10)
      $0.leadingToSuperview()
      $0.trailingToSuperview()
    }

    let dateView = UIView()
    dateView.do {
      contentView.addSubview($0)
      $0.leadingToSuperview()
      $0.trailingToSuperview()
      $0.height(44)
      $0.topToBottom(of: dateTitleLabel, offset: 6)
    }

    dateStartTextField.do {
      dateView.addSubview($0)
      $0.topToSuperview()
      $0.bottomToSuperview()
      $0.leadingToSuperview()
    }

    dateEndTextField.do {
      dateView.addSubview($0)
      $0.topToSuperview()
      $0.bottomToSuperview()
      $0.trailingToSuperview()
      $0.width(to: dateStartTextField)
      $0.leftToRight(of: dateStartTextField, offset: 15)
    }

    statusTitleLabel.do {
      contentView.addSubview($0)
      $0.topToBottom(of: dateView, offset: 15)
      $0.leadingToSuperview()
      $0.trailingToSuperview()
    }

    let statusStackView = UIStackView(arrangedSubviews: [graduatedButton, noncompletionButton, studyingButton])
    statusStackView.do {
      contentView.addSubview($0)
      $0.topToBottom(of: statusTitleLabel, offset: 10)
      $0.leftToSuperview()
      $0.rightToSuperview(relation: .equalOrLess)
      $0.height(25)
      $0.distribution = .equalSpacing
      $0.spacing = 30
    }

    majorTextField.do {
      contentView.addSubview($0)
      $0.topToBottom(of: statusStackView, offset: 40)
      $0.leadingToSuperview()
      $0.trailingToSuperview()
    }

    detailTitleLabel.do {
      contentView.addSubview($0)
      $0.topToBottom(of: majorTextField, offset: 40)
      $0.leadingToSuperview()
      $0.trailingToSuperview()
    }

    textView.do {
      contentView.addSubview($0)
      $0.topToBottom(of: detailTitleLabel, offset: 26)
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
    infoTitleLabel.attributedText = viewModel.infoTitleAttributedString
    levelTextField.title = viewModel.levelTitleAttributedString
    levelTextField.placeholder = viewModel.levelPlacehodlerAttributedString
    nameTextField.placeholder = viewModel.namePlacehodlerAttributedString
    dateTitleLabel.attributedText = viewModel.dateTitleAttributedString
    dateStartTextField.placeholder = viewModel.dateStartAttributedString
    dateEndTextField.placeholder = viewModel.dateEndAttributedString
    statusTitleLabel.attributedText = viewModel.statusTitleAttributedString
    majorTextField.title = viewModel.majorTitleAttributedString
    majorTextField.placeholder = viewModel.majorPlaceholderAttributedString
    detailTitleLabel.attributedText = viewModel.introTitleAttributedString
    textView.placeholder = R.string.localizable.profile_website_edit_education_intro_placeholder()
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

