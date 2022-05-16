//
//  IntroViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/14.
//

import UIKit
import TinyConstraints
import Then

class IntroViewController: UIViewController {

  let scrollView = UIScrollView().then {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
    $0.isPagingEnabled = true
  }

  let introView = UIView().then {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
  }

  let beginView = UIView().then {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .clear
  }

  let beginLabel = UILabel().then {
    $0.text = "準備開始"
  }
  let beginButton = UIButton().then {
    $0.setTitle(">>", for: .normal)
  }

  let tutorialView = UIView().then {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
  }

  let skipButton = UIButton().then {
    $0.setTitle("掠過", for: .normal)
  }

  let nextButton = UIButton().then {
    $0.setTitle(">>>", for: .normal)
  }

  let tutorialScrollView = UIScrollView().then {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .white
    $0.isPagingEnabled = true
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    configView()
  }

  private func configView() {
    scrollView.do {
      let viewWidth = self.view.frame.width
      let viewHeight = self.view.frame.height
      view.addSubview($0)
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.bottomToSuperview()
      $0.width(viewWidth)
      $0.addSubview(introView,
                    anchors: [.top(0), .bottom(0), .height(viewHeight), .width(viewWidth), .leading(0)])
      $0.addSubview(tutorialView,
                    anchors: [.top(0), .bottom(0), .height(viewHeight), .width(viewWidth), .leading(viewWidth), .trailing(0)])
    }

    beginView.do {
      introView.addSubview($0)
      $0.centerXToSuperview()
      $0.bottomToSuperview(offset: -80)
    }

    beginButton.do {
      beginView.addSubview($0)
      $0.height(40)
      $0.width(40)
      $0.topToSuperview()
      $0.bottomToSuperview()
      $0.rightToSuperview()
      $0.addTarget(self, action: #selector(onClickedBeginButton), for: .touchUpInside)
    }

    beginLabel.do {
      beginView.addSubview($0)
      $0.centerYToSuperview()
      $0.leftToSuperview()
      $0.rightToLeft(of: beginButton)
    }

    tutorialScrollView.do {
      let viewWidth = self.view.frame.width
      let viewHeight = self.view.frame.height
      tutorialView.addSubview($0)
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.height(viewHeight / 2)
      $0.width(viewWidth)
      let scrollView = $0
      for (index, feature) in TutorialFeature.allCases.enumerated() {
        UIView().do {
          $0.backgroundColor = feature.color
          scrollView.addSubview($0,
                                anchors: [.top(0),
                                          .bottom(0),
                                          .height(viewHeight / 2),
                                          .width(viewWidth),
                                          .leading(viewWidth * index.f)])
          if index == TutorialFeature.allCases.count - 1 {
            $0.trailingToSuperview()
          }
          let subView = $0
          UILabel().do {
            subView.addSubview($0)
            $0.text = feature.string
            $0.height(40)
            $0.centerXToSuperview()
            $0.bottomToSuperview(offset: -10)
            $0.sizeToFit()
          }
        }
      }
    }

    skipButton.do {
      tutorialView.addSubview($0)
      $0.height(40)
      $0.width(100)
      $0.topToSuperview(offset: 40)
      $0.rightToSuperview(offset: -40)
      $0.addTarget(self, action: #selector(onClickedSkipButton), for: .touchUpInside)
    }

    nextButton.do {
      tutorialView.addSubview($0)
      $0.height(40)
      $0.width(40)
      $0.bottomToSuperview(offset: -40)
      $0.rightToSuperview(offset: -40)
      $0.addTarget(self, action: #selector(onClickedNextButton(_:)), for: .touchUpInside)
    }

  }

  @objc
  private func onClickedBeginButton() {
    if self.scrollView.contentOffset.x < self.view.bounds.width {
      UIView.animate(withDuration: 0.25) { [weak self] in
        guard let self = self else { return }
        self.scrollView.contentOffset.x +=  self.view.bounds.width
      }
    }
  }

  @objc
  private func onClickedSkipButton() {
    UIView.animate(withDuration: 0.25) { [weak self] in
      guard let self = self else { return }
      self.dismiss(animated: true)
    }
  }

  @objc
  private func onClickedNextButton(_ sender: UIButton) {
    var canScroll: Bool { self.tutorialScrollView.contentOffset.x < self.view.bounds.width * (TutorialFeature.counts - 1).f }
    if canScroll {
      sender.isUserInteractionEnabled = false
      UIView.animate(withDuration: 0.5, animations: { [weak self] in
        guard let self = self else { return }
        self.tutorialScrollView.contentOffset.x +=  self.view.bounds.width
      }, completion: {_ in
        sender.isUserInteractionEnabled = true
        if !canScroll {
          UILabel().do {
            self.tutorialView.addSubview($0)
            $0.text = "tutorial_begin_to_try"
            $0.height(40)
            $0.centerY(to: sender)
            $0.rightToLeft(of: sender, offset: -10)
            $0.sizeToFit()
          }
        }
      })
    } else {
      dismiss(animated: true)
    }
  }
}

extension IntroViewController {
  enum TutorialFeature: CaseIterable {
    case feature_1
    case feature_2
    case feature_3
    case feature_4

    static var counts: Int {
      TutorialFeature.allCases.count
    }

    var string: String {
      switch self {
      case .feature_1:
        return "tutorialFeature_feature_text_1"
      case .feature_2:
        return "tutorialFeature_feature_text_2"
      case .feature_3:
        return "tutorialFeature_feature_text_3"
      case .feature_4:
        return "tutorialFeature_feature_text_4"
      }
    }

    var color: UIColor {
      switch self {
      case .feature_1:
        return #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
      case .feature_2:
        return #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
      case .feature_3:
        return #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
      case .feature_4:
        return #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
      }
    }
  }
}
