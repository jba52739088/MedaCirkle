//
//  MainViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/14.
//

import UIKit
import TinyConstraints

class MainViewController: UITabBarController {

  let topLine = UIView().then {
    $0.translatesAutoresizingMaskIntoConstraints = false
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupVCs()
    configTabbar()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.tabBar.isTranslucent = false

          sceneCoordinator.transit(to: .circle(CircleViewModel(data: tempCircleModel)), by: .overFullScreen, completion: nil)

//    if !AppDelegate.shared.didShowInrto {
//      sceneCoordinator.transit(to: .leading, by: .overFullScreen, completion: nil)
//        AppDelegate.shared.didShowInrto = true
//    }
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

  }

  private func configTabbar() {
    topLine.do {
      self.tabBar.addSubview($0)
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.topToSuperview()
      $0.height(3)
    }
    view.layoutIfNeeded()
    topLine.applyGradient(isVertical: false, colorArray: [.tabbarGradientYellow, .tabbarGradientPurple, .tabbarGradientBlue])
  }

  private func presentInrtoView() {
    let introVC = IntroViewController()
    introVC.modalPresentationStyle = .fullScreen
    present(introVC, animated: false)
  }

  private func setupVCs() {
    viewControllers = BarPageType.allCases.map({
      self.createNavController(for: $0)
    })
  }

  private func createNavController(for pageType: BarPageType) -> UIViewController {
    let vc = pageType.viewController
    let navController = UINavigationController(rootViewController: vc)
    navController.tabBarItem.title = pageType.title
    navController.tabBarItem.image = pageType.tabBarImage
    navController.tabBarItem.selectedImage = pageType.tabBarSelectedImage
    navController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    navController.navigationBar.prefersLargeTitles = false
    navController.navigationBar.isHidden = true
    vc.navigationItem.title = pageType.title
    return navController
  }
}

extension MainViewController {
  enum BarPageType: String, CaseIterable {
    case BigCircle
    case Circle
    case Home
    case Message
    case Member

    var title: String {
      switch self {
      case .Home:
        return R.string.localizable.tool_bar_home()
      case .Circle:
        return R.string.localizable.tool_bar_circle()
      case .BigCircle:
        return R.string.localizable.tool_bar_big_circle()
      case .Message:
        return R.string.localizable.tool_bar_message()
      case .Member:
        return R.string.localizable.tool_bar_member()
      }
    }

    var viewController: UIViewController {
      switch self {
      case .Home:
        return HomeViewController()
      case .Circle:
        return CircleMainViewController()
      case .BigCircle:
        return PublicViewController()
      case .Message:
        return MassageViewController()
      case .Member:
        return MemberViewController()
      }
    }

    var tabBarImage: UIImage? {
      switch self {
      case .Home:
        return R.image.icon_bottom_bar_s_bigcircle_02()
      case .Circle:
        return R.image.icon_bottom_bar_s_circle_02()
      case .BigCircle:
        return R.image.icon_bottom_bar_home_02()
      case .Message:
        return R.image.icon_bottom_bar_s_message_02()
      case .Member:
        return R.image.icon_bottom_bar_member()
      }
    }

    var tabBarSelectedImage: UIImage? {
      switch self {
      case .Home:
        return R.image.icon_bottom_bar_s_bigcircle_02_b_full()
      case .Circle:
        return R.image.icon_bottom_bar_s_circle_02_b_full()
      case .BigCircle:
        return R.image.icon_bottom_bar_home_02_b_full()
      case .Message:
        return R.image.icon_bottom_bar_s_message_02_b_full()
      case .Member:
        return R.image.icon_bottom_bar_member_b_full()
      }
    }
  }
}
