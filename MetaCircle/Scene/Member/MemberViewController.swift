//
//  MemberViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/15.
//

import UIKit

class MemberViewController: UIViewController {

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

  override func viewDidLoad() {
    super.viewDidLoad()
    if !MainAppService.shared.isLogin {
      sceneCoordinator.transit(to: .login, by: .overFullScreen, completion: nil)
    }
    configView()
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
  }

}
