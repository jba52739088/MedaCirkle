//
//  TopGradientViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/18.
//

import UIKit

class TopGradientViewController: BaseViewController {

  let gradientView = UIView()

  override func viewDidLoad() {
    super.viewDidLoad()

    configGradientView()
  }

  private func configGradientView() {
    gradientView.do {
      view.addSubview($0)
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.height(212)
    }
    view.layoutIfNeeded()
    gradientView.applyGradient(isVertical: false, colorArray: [.backgroundGradientYellow, .backgroundGradientPurple, .backgroundGradientBlue])

    let gradientLayer = CAGradientLayer()
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
    gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.9)
    gradientLayer.colors = [UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
    gradientLayer.locations = [0, 0.6, 1]
    gradientLayer.frame = gradientView.bounds
    gradientView.layer.mask = gradientLayer
  }
}
