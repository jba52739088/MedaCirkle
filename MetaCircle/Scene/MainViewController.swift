//
//  MainViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/14.
//

import UIKit

class MainViewController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()


    self.view.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
    // Do any additional setup after loading the view.
    UITabBar.appearance().barTintColor = .systemGray
    tabBar.tintColor = .darkGray
    setupVCs()


  }

  

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    let introVC = IntroViewController()
    introVC.modalPresentationStyle = .fullScreen
    self.present(introVC, animated: false)

  }

  private func setupVCs() {
    viewControllers = [
      createNavController(for: HomeViewController(), title: "1", image: nil),
      createNavController(for: PublicViewController(), title: "2", image: nil),
      createNavController(for: PrivateViewController(), title: "3", image: nil),
      createNavController(for: MemberViewController(), title: "4", image: nil)
    ]
  }

  private func createNavController(for rootViewController: UIViewController,
                                       title: String,
                                       image: UIImage?) -> UIViewController {
    let navController = UINavigationController(rootViewController: rootViewController)
    navController.tabBarItem.title = title
    navController.tabBarItem.image = image
    navController.navigationBar.prefersLargeTitles = false
    rootViewController.navigationItem.title = title
    return navController
  }
}
