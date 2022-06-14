//
//  PrivateViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/15.
//

import UIKit
import TinyConstraints
import RxSwift
import RxCocoa

class CircleMainViewController: BaseViewController {

  let navView = UIView().then {
    $0.backgroundColor = .normalLightBg
  }
  let mainContain = UIView()
  let logoImgView = UIImageView() .then {
    $0.image = R.image.logo_2()
    $0.contentMode = .scaleAspectFit
  }
  let searchBtn: UIButton = UIView.searchBarButton()
  let bellBtn: UIButton = UIView.bellButton()
  let titleLabel = UILabel()
  let addBtn = UIButton()
  let joinedBtn = UIButton()
  let createdBtn = UIButton()
  let selectedBar = UIView()
  var barWidthConstraint: Constraint?
  var barLeftConstraint: Constraint?
  var barRightConstraint: Constraint?

  let joinedContentVC: CircleListViewController
  let createdContentVC: CircleListViewController

  let viewModel: CircleMainViewModel

  init(_ viewModel: CircleMainViewModel = CircleMainViewModel()) {
    self.viewModel = viewModel
    joinedContentVC = CircleListViewController(CircleListViewModel(type: .Joined))
    createdContentVC = CircleListViewController(CircleListViewModel(type: .Created))
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


    self.addChild(joinedContentVC)
    joinedContentVC.didMove(toParent: self)
    self.addChild(createdContentVC)
    createdContentVC.didMove(toParent: self)

    configView()
    bindViewModel()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    didTapCategoryBtn(joinedBtn)
  }

  private func configView() {
    view.normalBackgroundGradient()
    navView.do {
      view.addSubview($0)
      $0.topToSuperview()
      $0.leadingToSuperview(offset: 0)
      $0.trailingToSuperview(offset: 0)
    }

    mainContain.do {
      view.addSubview($0)
      $0.backgroundColor = .clear
      $0.topToBottom(of: navView)
      $0.leadingToSuperview(offset: 0)
      $0.trailingToSuperview(offset: 0)
      $0.bottomToSuperview()
      let mainView = $0
      joinedContentVC.view.do {
        mainView.addSubview($0)
        $0.topToSuperview()
        $0.leadingToSuperview(offset: 0)
        $0.trailingToSuperview(offset: 0)
        $0.bottomToSuperview()
        $0.isHidden = true
      }
      createdContentVC.view.do {
        mainView.addSubview($0)
        $0.topToSuperview()
        $0.leadingToSuperview(offset: 0)
        $0.trailingToSuperview(offset: 0)
        $0.bottomToSuperview()
        $0.isHidden = true
      }
    }

    logoImgView.do {
      navView.addSubview($0)
      $0.width(126.2)
      $0.height(18.35)
      $0.topToSuperview(offset: 16, usingSafeArea: true)
      $0.leadingToSuperview(offset: 15)
    }

    bellBtn.do {
      navView.addSubview($0)
      $0.width(26)
      $0.height(26)
      $0.centerY(to: logoImgView)
      $0.rightToSuperview(offset: -15)
    }

    searchBtn.do {
      navView.addSubview($0)
      $0.width(26)
      $0.height(26)
      $0.centerY(to: logoImgView)
      $0.rightToLeft(of: bellBtn, offset: -17)
    }

    titleLabel.do {
      navView.addSubview($0)
      $0.topToBottom(of: logoImgView, offset: 18.5)
      $0.leadingToSuperview(offset: 23)
    }

    addBtn.do {
      navView.addSubview($0)
      $0.setImage(R.image.icon_btn_pluss(), for: .normal)
      $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -3, bottom: 0, right: 3)
      $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: -3)
      $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
      $0.backgroundColor = .btnBlue
      $0.height(30)
      $0.centerY(to: titleLabel)
      $0.rightToSuperview(offset: -13)
      $0.layer.cornerRadius = 15
      $0.layer.masksToBounds = true
      $0.addTarget(self, action: #selector(didTapAddBtn), for: .touchUpInside)

    }

    joinedBtn.do {
      navView.addSubview($0)
      $0.topToBottom(of: titleLabel, offset: 12)
      $0.leadingToSuperview(offset: 17)
      $0.bottomToSuperview()
      $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 9, right: 12)
      $0.addTarget(self, action: #selector(didTapCategoryBtn(_:)), for: .touchUpInside)
    }

    createdBtn.do {
      navView.addSubview($0)
      $0.topToBottom(of: titleLabel, offset: 12)
      $0.leftToRight(of: joinedBtn)
      $0.bottomToSuperview()
      $0.height(to: joinedBtn)
      $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 9, right: 12)
      $0.addTarget(self, action: #selector(didTapCategoryBtn(_:)), for: .touchUpInside)
    }

    selectedBar.do {
      navView.addSubview($0)
      $0.bottomToSuperview()
      $0.height(3)
      $0.layer.cornerRadius = 1.5
      $0.layer.masksToBounds = true
    }
  }

  private func bindViewModel() {
    titleLabel.attributedText = viewModel.titleAttributedString
    addBtn.setAttributedTitle(viewModel.addButtonAttributedString, for: .normal)
    joinedBtn.setAttributedTitle(viewModel.joinedButtonNormalAttributedString, for: .normal)
    joinedBtn.setAttributedTitle(viewModel.joinedButtonSelectedAttributedString, for: .selected)
    createdBtn.setAttributedTitle(viewModel.createdButtonNormalAttributedString, for: .normal)
    createdBtn.setAttributedTitle(viewModel.createdButtonSelectedAttributedString, for: .selected)

  }
}

extension CircleMainViewController {
  @objc
  private func didTapCategoryBtn(_ sender: UIButton) {
    if sender.isSelected { return }
    let selectedBtn = sender
    guard let unselectedBtn = [joinedBtn, createdBtn].first(where: { $0 != selectedBtn })
    else { return }
    selectedBtn.isSelected = true
    unselectedBtn.isSelected = false
    barLeftConstraint?.isActive = false
    barRightConstraint?.isActive = false
    barLeftConstraint = selectedBar.leading(to: selectedBtn)
    barRightConstraint = selectedBar.trailing(to: selectedBtn)

    UIView.animate(withDuration: 0.3) { [weak self] in
      guard let self = self else { return }
      self.selectedBar.frame.size = CGSize(width: sender.frame.width, height: 3.f)
      self.selectedBar.applyGradient(isVertical: false, colorArray: [.tabbarGradientYellow, .tabbarGradientPurple, .tabbarGradientBlue])
      self.navView.layoutSubviews()
    }

    joinedContentVC.view.isHidden = createdBtn.isSelected
    createdContentVC.view.isHidden = joinedBtn.isSelected
    //    navView.layoutIfNeeded()
    //    selectedBar.applyGradient(isVertical: false, colorArray: [.tabbarGradientYellow, .tabbarGradientPurple, .tabbarGradientBlue])
  }

  @objc
  private func didTapAddBtn() {
    sceneCoordinator.transit(to: .createCircle, by: .overFullScreen, completion: nil)
  }
}
