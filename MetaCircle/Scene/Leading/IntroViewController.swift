//
//  IntroViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/14.
//

import UIKit
import TinyConstraints
import Then
import RxRelay
import RxSwift

class IntroViewController: BaseViewController {

  static let dismissIntroRelay = PublishRelay<Bool>()

  let scrollView = UIScrollView().then {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .clear
    $0.bounces = false
    $0.alwaysBounceVertical = false
    $0.isPagingEnabled = true
    $0.showsVerticalScrollIndicator = false
    $0.showsHorizontalScrollIndicator = false
    $0.isScrollEnabled = false
  }

  let introView = UIView().then {
    $0.backgroundColor = .clear
  }

  let beginView = UIView().then {
    $0.backgroundColor = .clear
  }

  let topLogo = UIImageView().then {
    $0.image = R.image.img_hello()
    $0.contentMode = .scaleAspectFit
    $0.backgroundColor = .clear
  }

  let girlImgView = UIImageView().then {
    $0.image = R.image.img_little_girl()
    $0.contentMode = .scaleAspectFit
    $0.backgroundColor = .clear
  }

  let beginLabel = UILabel()
  let beginButton = UIButton(type: .custom)

  let tutorialView = UIView().then {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .clear
  }

  let tutorialLogo = UIImageView().then {
    $0.image = R.image.logo_2()
    $0.contentMode = .scaleAspectFit
    $0.backgroundColor = .clear
  }

  let tutorialBg = UIImageView().then {
    $0.image = R.image.bg_3()
    $0.contentMode = .scaleAspectFit
    $0.backgroundColor = .clear
  }

  let tutorialLabel = UILabel().then {
    $0.numberOfLines = 0
  }

  let skipButton = UIButton(type: .custom)
  let nextButton = UIButton(type: .custom)

  let tutorialScrollView = UIScrollView().then {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .white
    $0.bounces = false
    $0.isPagingEnabled = true
    $0.showsVerticalScrollIndicator = false
    $0.showsHorizontalScrollIndicator = false
  }

  var viewModel: IntroViewModel

  init(_ viewModel: IntroViewModel = IntroViewModel()) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .normalLightBg
    configView()
    bindViewModel()

    IntroViewController.dismissIntroRelay
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: {[weak self] _ in
        guard let self = self else { return }
        self.dismiss(animated: false)
      })
      .disposed(by: disposeBag)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  deinit {
    disposeBag = DisposeBag()
  }

  private func configView() {
    scrollView.do {
      view.addSubview($0)
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.bottomToSuperview()
      $0.rightToSuperview()
    }

    let contentView = UIView()
    contentView.do {
      scrollView.addSubview($0)
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.bottomToSuperview(usingSafeArea: true)
      $0.rightToSuperview()
      $0.width(UIScreen.main.bounds.width * 2)
    }

    introView.do {
      contentView.addSubview($0)
      $0.topToSuperview()
      $0.bottomToSuperview()
      $0.leftToSuperview()
      $0.width(UIScreen.main.bounds.width)
      $0.rightToSuperview(offset: -UIScreen.main.bounds.width)
    }

    tutorialView.do {
      contentView.addSubview($0)
      $0.topToSuperview()
      $0.bottomToSuperview()
      $0.rightToSuperview()
      $0.width(UIScreen.main.bounds.width)
      $0.leftToRight(of: introView)
    }

    topLogo.do {
      introView.addSubview($0)
      $0.centerXToSuperview()
      $0.topToSuperview(offset: 60)
      $0.leftToSuperview(offset: 27.5)
      $0.rightToSuperview(offset: -27.5)
    }

    girlImgView.do {
      introView.addSubview($0)
      $0.centerXToSuperview()
      $0.topToBottom(of: topLogo, offset: 36.31)
      $0.leftToSuperview(offset: 49)
      $0.rightToSuperview(offset: -49)
    }

    beginView.do {
      introView.addSubview($0)
      $0.leftToSuperview(offset: 40)
      $0.bottomToSuperview(offset: -51)
    }

    beginButton.do {
      beginView.addSubview($0)
      $0.height(44)
      $0.width(44)
      $0.topToSuperview()
      $0.bottomToSuperview()
      $0.rightToSuperview()
      $0.addTarget(self, action: #selector(onClickedBeginButton), for: .touchUpInside)
      $0.setImage(R.image.icon_arrow_3_right(), for: .normal)
      $0.backgroundColor = .btnBlue
      $0.layer.cornerRadius = 22
      $0.layer.masksToBounds = true
    }

    beginLabel.do {
      beginView.addSubview($0)
      $0.centerYToSuperview()
      $0.leftToSuperview()
      $0.rightToLeft(of: beginButton, offset: -8)
    }

    skipButton.do {
      introView.addSubview($0)
      $0.rightToSuperview(offset: -40)
      $0.centerY(to: beginView)
      $0.addTarget(self, action: #selector(onClickedSkipButton), for: .touchUpInside)
    }

    // change page

    UIImageView().do {
      $0.image = R.image.bg_3()
      $0.contentMode = .scaleAspectFit
      $0.backgroundColor = .clear
      tutorialView.addSubview($0)
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.rightToSuperview()
    }

    tutorialBg.do {
      tutorialView.addSubview($0)
      $0.topToSuperview(usingSafeArea: true)
      $0.leftToSuperview()
      $0.rightToSuperview()
    }

    tutorialScrollView.do {
      tutorialView.addSubview($0)
      $0.backgroundColor = .clear
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.bottom(to: tutorialBg)
      $0.rightToSuperview()
    }

    let featureContent = UIView()
    featureContent.do {
      tutorialScrollView.addSubview($0)
      $0.backgroundColor = .clear
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.bottomToSuperview()
      $0.rightToSuperview()
      $0.height(to: tutorialScrollView)
      $0.width(UIScreen.main.bounds.width * TutorialFeature.allCases.count.f)
    }

    for (index, feature) in TutorialFeature.allCases.enumerated() {
      UIView().do {
        featureContent.addSubview($0)
        $0.backgroundColor = .clear
        $0.width(UIScreen.main.bounds.width)
        $0.topToSuperview()
        $0.bottomToSuperview()
        if index == 0 {
          $0.leftToSuperview()
        } else if index == TutorialFeature.allCases.count - 1 {
          $0.rightToSuperview()
        } else {
          $0.leftToSuperview(offset: index.f * UIScreen.main.bounds.width)
        }
        let subView = $0
        UIImageView().do {
          subView.addSubview($0)
          $0.image = feature.image
          $0.topToSuperview(usingSafeArea: true)
          $0.leftToSuperview()
          $0.rightToSuperview()
          $0.bottomToSuperview()
          $0.contentMode = .scaleAspectFit
        }
//        UILabel().do {
//          subView.addSubview($0)
//          $0.numberOfLines = 0
//          $0.attributedText = viewModel.featureAttributedString(feature.string)
//          $0.leftToSuperview(offset: 70)
//          $0.bottomToSuperview(offset: -48)
//        }
      }
    }

    tutorialLogo.do {
      tutorialView.addSubview($0)
      $0.topToSuperview(offset: 24, usingSafeArea: true)
      $0.leftToSuperview(offset: 28)
      $0.height(18.35)
    }

    tutorialLabel.do {
      tutorialView.addSubview($0)
      $0.numberOfLines = 0
      $0.attributedText = viewModel.featureAttributedString(TutorialFeature.feature_1.string)
      $0.leftToSuperview(offset: 70)
      $0.bottom(to: tutorialBg, offset: -48)
    }

    nextButton.do {
      tutorialView.addSubview($0)
      $0.setImage(R.image.icon_arrow_3_right(), for: .normal)
      $0.height(28)
      $0.width(28)
      $0.bottomToSuperview(offset: -28)
      $0.rightToSuperview(offset: -28)
      $0.addTarget(self, action: #selector(onClickedNextButton(_:)), for: .touchUpInside)
      $0.backgroundColor = .btnBlue
      $0.layer.cornerRadius = 14
      $0.layer.masksToBounds = true
    }

  }

  private func bindViewModel() {
    beginLabel.attributedText = viewModel.registerAttributedString
    skipButton.setAttributedTitle(viewModel.skipAttributedString, for: .normal)
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
      UIView.transition(with: tutorialLabel,
                        duration: 0.5,
                        options: .transitionCrossDissolve,
                        animations: { [weak self] in
        guard let self = self else { return }
        let count = (self.tutorialScrollView.contentOffset.x + self.view.bounds.width) / self.view.bounds.width
        if let string = TutorialFeature.allCases[safe: Int(count)]?.string {
          self.tutorialLabel.attributedText = self.viewModel.featureAttributedString(string)
        }
      }, completion: nil)
      UIView.animate(withDuration: 0.5, animations: { [weak self] in
        guard let self = self else { return }
        self.tutorialScrollView.contentOffset.x +=  self.view.bounds.width
      }, completion: { [weak self, weak sender] _ in
        guard let self = self, let sender = sender else { return }
        sender.isUserInteractionEnabled = true
        if !canScroll {
          UILabel().do {
            self.tutorialView.addSubview($0)
            $0.attributedText = self.viewModel.beginAttributedString
            $0.centerY(to: sender)
            $0.rightToLeft(of: sender, offset: -7)
            $0.sizeToFit()
          }
        }
      })
    } else {
      presentTopicVC()
    }
  }

  private func presentTopicVC() {
    let topicVC = TopicViewController()
    topicVC.modalPresentationStyle = .fullScreen
    let transition = CATransition()
    transition.duration = 0.25
    transition.type = CATransitionType.moveIn
    transition.subtype = CATransitionSubtype.fromRight
//    transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.default)
    view.window?.layer.add(transition, forKey: kCATransition)
    present(topicVC, animated: false, completion: nil)
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
        return R.string.localizable.leading_tutorial_feature_text_1()
      case .feature_2:
        return R.string.localizable.leading_tutorial_feature_text_2()
      case .feature_3:
        return R.string.localizable.leading_tutorial_feature_text_3()
      case .feature_4:
        return R.string.localizable.leading_tutorial_feature_text_4()
      }
    }

    var image: UIImage? {
      switch self {
      case .feature_1:
        return R.image.img_leading_01()
      case .feature_2:
        return R.image.img_leading_02()
      case .feature_3:
        return R.image.img_leading_03()
      case .feature_4:
        return nil
      }
    }
  }
}
