//
//  TopicViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/17.
//

import UIKit
import TinyConstraints
import Then

class TopicViewController: UIViewController {

  let tipLabel = UILabel().then {
    $0.text = "topicView_tip"
  }
  let titleLabel = UILabel().then {
    $0.text = "topicView_title"
  }
  let subtitleLabel = UILabel().then {
    $0.text = "topicView_subtitle"
  }

  let nextButton = UIButton(type: .custom).then {
    $0.setTitle("topicView_nextButton", for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.backgroundColor = .btnBlue
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    configView()
  }

  private func configView() {
//    tipLabel.do {
//      view.addSubview($0)
//      $0.topToSuperview(offset: 10, usingSafeArea: true)
//      $0.rightToSuperview(offset: -10)
//    }

    titleLabel.do {
      view.addSubview($0)
      $0.topToSuperview(offset: 30, usingSafeArea: true)
      $0.leftToSuperview(offset: 20)
    }

    subtitleLabel.do {
      view.addSubview($0)
      $0.topToBottom(of: titleLabel, offset: 10)
      $0.leftToSuperview(offset: 20)
    }

    nextButton.do {
      view.addSubview($0)
      $0.height(30)
      $0.width(74)
      $0.layer.cornerRadius = 15
      $0.layer.masksToBounds = true
      $0.topToSuperview(offset: 10, usingSafeArea: true)
      $0.rightToSuperview(offset: -10)
      $0.addTarget(self, action: #selector(onClickedNextButton), for: .touchUpInside)
    }
  }

  @objc private func onClickedNextButton() {
    self.dismiss(animated: true)
    IntroViewController.dismissIntroRelay.accept(true)
  }
}
