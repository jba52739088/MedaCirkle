//
//  MainViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/14.
//

import UIKit
import TinyConstraints

class MainViewController: UITabBarController {

  var didShowInrto: Bool = false
  let topLine = UIView().then {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .btnBlue
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupVCs()
    configTabbar()
  }

  

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.tabBar.isTranslucent = false
    UITabBar.appearance().barTintColor = .white
    if !didShowInrto {
//      presentInrtoView()
//      didShowInrto = true
    }

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
      self.createNavController(for: $0.viewController, title: $0.rawValue, image: nil)
    })
  }

  private func createNavController(for rootViewController: UIViewController,
                                       title: String,
                                       image: UIImage?) -> UIViewController {
    let navController = UINavigationController(rootViewController: rootViewController)
    navController.tabBarItem.title = title
    navController.tabBarItem.image = image
    navController.navigationBar.prefersLargeTitles = false
    navController.navigationBar.isHidden = true
    rootViewController.navigationItem.title = title
    return navController
  }
}

extension MainViewController {
  enum BarPageType: String, CaseIterable {
    case Home
    case Circle
    case BigCircle
    case Message
    case Member

    var viewController: UIViewController {
      switch self {
      case .Home:
        return HomeViewController()
      case .Circle:
        return PrivateViewController()
      case .BigCircle:
        return PublicViewController()
      case .Message:
        return MassageViewController()
      case .Member:
        return LoginViewController(LoginViewModel())
//        return MemberViewController()
      }
    }
  }
}
