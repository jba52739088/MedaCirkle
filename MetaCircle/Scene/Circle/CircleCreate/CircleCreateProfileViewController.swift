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
  private let nextBtn = UIButton(type: .custom)
  private let titleLabel = UILabel()
  private let scrollView = UIScrollView().then {
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
  private let bannerView = UIView().then {
    $0.backgroundColor = .btnGray
  }
  private let bannerBtn = UIButton(type: .custom)
  private let avatarBtn = UIButton(type: .custom)
  private let nameLabel = UILabel()
  private let infoView = UIView().then {
    $0.backgroundColor = .textFieldNormalBg
  }
  let textView = UITextView().then {
    $0.backgroundColor = .clear
    $0.textContainerInset = UIEdgeInsets(top: 13, left: 22, bottom: 13, right: 22)
  }

  let viewModel: CircleCreateProfileViewModel

  init(_ viewModel: CircleCreateProfileViewModel = CircleCreateProfileViewModel()) {
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

    nextBtn.do {
      topView.addSubview($0)
      $0.contentEdgeInsets = UIEdgeInsets(top: 2, left: 18, bottom: 2, right: 18)
      $0.height(26)
      $0.centerYToSuperview()
      $0.rightToSuperview(offset: -15)
      $0.layer.cornerRadius = 13
      $0.layer.masksToBounds = true
      $0.addTarget(self, action: #selector(didTapnextBtn), for: .touchUpInside)
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

    bannerView.do {
      contentView.addSubview($0)
      $0.topToSuperview()
      $0.leadingToSuperview()
      $0.trailingToSuperview()
      $0.height(184)
    }

    bannerBtn.do {
      bannerView.addSubview($0)
      $0.topToSuperview(offset: 63.75)
      $0.centerXToSuperview()
      $0.height(40)
    }

    avatarBtn.do {
      contentView.addSubview($0)
      $0.topToBottom(of: bannerView, offset: -36)
      $0.centerXToSuperview()
      $0.width(72)
    }

    nameLabel.do {
      contentView.addSubview($0)
      $0.topToBottom(of: avatarBtn, offset: 23)
      $0.centerXToSuperview()
    }

    infoView.do {
      contentView.addSubview($0)
      $0.topToBottom(of: nameLabel, offset: 15)
      $0.leadingToSuperview(offset: 38)
      $0.trailingToSuperview(offset: 38)
      $0.height(150)
      $0.bottomToSuperview(offset: 30, relation: .equalOrLess)
      $0.layer.cornerRadius = 15
      $0.layer.masksToBounds = true
    }
  }


  private func bindViewModel() {
//    nextBtn.setAttributedTitle(viewModel.addButtonNormalAttributedString, for: .normal)
//    nextBtn.setAttributedTitle(viewModel.addButtonDisableAttributedString, for: .disabled)
//    titleLabel.attributedText = viewModel.titleAttributedString

    bannerView.rx.tapGesture()
      .when(.recognized)
      .subscribe(onNext: { [weak self] _ in
        guard let self = self else { return }
//        self.privacyOptionCheckBtn.isSelected = !self.privacyOptionCheckBtn.isSelected
      })
      .disposed(by: disposeBag)
  }

//  private func configTextViewEvent() {
//    textView.rx.didBeginEditing
//      .observeOn(MainScheduler.instance)
//      .subscribe(onNext: { [weak self] in
//        guard let self = self else { return }
//        if self.textView.attributedText == self.viewModel.feedbackPlaceholderAttributedString {
//          self.textView.text = ""
//          self.textView.attributedText = nil
//        }
//      })
//      .disposed(by: disposeBag)
//
//    textView.rx.didChange
//      .observeOn(MainScheduler.instance)
//      .subscribe(onNext: { [weak self] in
//        guard let self = self else { return }
//
//      })
//      .disposed(by: disposeBag)
//
//    textView.rx.text.orEmpty.changed
//      .observeOn(MainScheduler.instance)
//      .subscribe(onNext: { [weak self] _ in
//        guard let self = self else { return }
//        self.configSubmitButtonState()
//      })
//      .disposed(by: disposeBag)
//
//  }

  @objc
  private func didTapBackButton() {
    sceneCoordinator.dismiss(animated: true, completion: nil)
  }

  @objc
  private func didTapnextBtn() {
  }


}
