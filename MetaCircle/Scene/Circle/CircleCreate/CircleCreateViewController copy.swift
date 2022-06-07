//
//  CircleCreateProfileViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/3.
//

import UIKit
import TinyConstraints
import RxSwift
import RxCocoa
import RxGesture

class CircleCreateProfileViewController: BaseViewController {

  private let topView = UIView().then {
    $0.backgroundColor = .clear
  }
  private lazy var backButton: UIButton = .backButton(target: self, action: #selector(didTapBackButton))
  private let addBtn = UIButton(type: .custom)
  private let titleLabel = UILabel()
  private let scrollView = UIScrollView().then {
    $0.translatesAutoresizingMaskIntoConstraints = false
//    $0.bounces = false
//    $0.showsVerticalScrollIndicator = false
//    $0.showsHorizontalScrollIndicator = false
  }
  let nameTextField = NormalTextField()
  let categoryTextField = NormalTextField()
  let privacyLabel = UILabel()
  private lazy var privacyPublicView = PrivacyCheckBoxView(privacy: .Public, delegate: self)
  private lazy var privacyOptionalView = PrivacyCheckBoxView(privacy: .Optional, delegate: self)
  private lazy var privacyPrivateView = PrivacyCheckBoxView(privacy: .Private, delegate: self)
  let privacyLevelLabel = UILabel()
  let privacyOptionView = UIView()
  let privacyOptionCheckBtn = UIButton().then {
    $0.isUserInteractionEnabled = false
  }
  let privacyOptionLabel = UILabel().then {
    $0.numberOfLines = 0
  }

  var didSelectPrivacy: CircleCreateViewModel.Privacy? = nil
  let viewModel: CircleCreateViewModel

  init(_ viewModel: CircleCreateViewModel = CircleCreateViewModel()) {
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
      $0.leftToSuperview(offset: 10, usingSafeArea: true)
      $0.centerYToSuperview()
    }

    titleLabel.do {
      topView.addSubview($0)
      $0.centerYToSuperview()
      $0.centerXToSuperview()
    }

    addBtn.do {
      topView.addSubview($0)
      $0.contentEdgeInsets = UIEdgeInsets(top: 2, left: 18, bottom: 2, right: 18)
      $0.height(26)
      $0.centerYToSuperview()
      $0.rightToSuperview(offset: -15)
      $0.layer.cornerRadius = 13
      $0.layer.masksToBounds = true
      $0.addTarget(self, action: #selector(didTapAddBtn), for: .touchUpInside)
      $0.setBackgroundImage(.withColor(.btnGray), for: .disabled)
      $0.setBackgroundImage(.withColor(.btnBlue), for: .normal)
      $0.isEnabled = false

    }

    scrollView.do {
      view.addSubview($0)
      $0.topToBottom(of: topView)
      $0.leftToSuperview()
      $0.bottomToSuperview(usingSafeArea: true)
      $0.rightToSuperview()
    }

    let contentView = UIView()
    contentView.do {
      scrollView.addSubview($0)
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.bottomToSuperview(usingSafeArea: true)
      $0.rightToSuperview()
      $0.width(UIScreen.main.bounds.width)
    }

    nameTextField.do {
      contentView.addSubview($0)
      $0.topToSuperview(offset: 29)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
    }

    categoryTextField.do {
      contentView.addSubview($0)
      $0.topToBottom(of: nameTextField, offset: 35)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
    }

    privacyLabel.do {
      contentView.addSubview($0)
      $0.topToBottom(of: categoryTextField, offset: 35)
      $0.leadingToSuperview(offset: 38)
    }

    privacyPublicView.do {
      contentView.addSubview($0)
      $0.topToBottom(of: privacyLabel, offset: 6)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
      $0.height(75)
      $0.layer.cornerRadius = 10.f
      $0.layer.masksToBounds = true
      $0.layer.borderColor = UIColor.optionCheckBtnBorder.cgColor
      $0.layer.borderWidth = 1.f
    }

    privacyOptionalView.do {
      contentView.addSubview($0)
      $0.topToBottom(of: privacyPublicView, offset: 10)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
      $0.height(75)
      $0.layer.cornerRadius = 10.f
      $0.layer.masksToBounds = true
      $0.layer.borderColor = UIColor.optionCheckBtnBorder.cgColor
      $0.layer.borderWidth = 1.f
    }

    privacyPrivateView.do {
      contentView.addSubview($0)
      $0.topToBottom(of: privacyOptionalView, offset: 10)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
      $0.height(75)
      $0.layer.cornerRadius = 10.f
      $0.layer.masksToBounds = true
      $0.layer.borderColor = UIColor.optionCheckBtnBorder.cgColor
      $0.layer.borderWidth = 1.f
    }

    privacyLevelLabel.do {
      contentView.addSubview($0)
      $0.topToBottom(of: privacyPrivateView, offset: 35)
      $0.leadingToSuperview(offset: 38)
    }

    privacyOptionView.do {
      contentView.addSubview($0)
      $0.topToBottom(of: privacyLevelLabel, offset: 12)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
      $0.bottomToSuperview(offset: 30, relation: .equalOrLess)
    }

    privacyOptionCheckBtn.do {
      privacyOptionView.addSubview($0)
      $0.setImage(R.image.checkbox(), for: .normal)
      $0.setImage(R.image.checkbox_selected(), for: .selected)
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.height(25)
      $0.width(25)
    }

    privacyOptionLabel.do {
      privacyOptionView.addSubview($0)
      $0.topToSuperview()
      $0.leftToRight(of: privacyOptionCheckBtn, offset: 12)
      $0.rightToSuperview()
      $0.bottomToSuperview(relation: .equalOrLess)
    }
  }


  private func bindViewModel() {
    addBtn.setAttributedTitle(viewModel.addButtonNormalAttributedString, for: .normal)
    addBtn.setAttributedTitle(viewModel.addButtonDisableAttributedString, for: .disabled)
    titleLabel.attributedText = viewModel.titleAttributedString
    nameTextField.title = viewModel.circleNameAttributedString
    nameTextField.placeholder = viewModel.circleNamePlaceholderAttributedString
    categoryTextField.title = viewModel.categoryAttributedString
    categoryTextField.placeholder = viewModel.categoryPlaceholderAttributedString
    privacyLabel.attributedText = viewModel.privacyAttributedString
    privacyLevelLabel.attributedText = viewModel.privacyLevelAttributedString
    privacyOptionLabel.attributedText = viewModel.privacyLevelOptionAttributedString

    privacyOptionView.rx.tapGesture()
      .when(.recognized)
      .subscribe(onNext: { [weak self] _ in
        guard let self = self else { return }
        self.privacyOptionCheckBtn.isSelected = !self.privacyOptionCheckBtn.isSelected
      })
      .disposed(by: disposeBag)
  }

  @objc
  private func didTapBackButton() {
    sceneCoordinator.dismiss(animated: true, completion: nil)
  }

  @objc
  private func didTapAddBtn() {
  }


}

//MARK: PrivacyCheckBoxDelegate
extension CircleCreateProfileViewController: PrivacyCheckBoxDelegate {
  func didSelect(_ view: PrivacyCheckBoxView) {
    let privacyOptions = [self.privacyPublicView, self.privacyOptionalView, self.privacyPrivateView]
    privacyOptions.forEach { privacyView in
      if privacyView == view {
        view.didSelected = !view.didSelected
      } else {
        privacyView.didSelected = false
      }
    }
    self.didSelectPrivacy = privacyOptions.first(where: { $0.didSelected == true })?.privacy
  }
}
