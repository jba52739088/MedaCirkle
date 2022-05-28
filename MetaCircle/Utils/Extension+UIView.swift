//
//  Extension+UIView.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/18.
//

import UIKit

extension UIView {
  /// Helper to configure layouts: subview's frame == self.bounds
  func embedSubview(_ subview: UIView) {
    // do nothing if this view is already in the right place
    if subview.superview == self { return }

    if subview.superview != nil {
      subview.removeFromSuperview()
    }

    subview.translatesAutoresizingMaskIntoConstraints = false

    subview.frame = bounds
    addSubview(subview)

    NSLayoutConstraint.activate(
      [
        subview.leadingAnchor.constraint(equalTo: leadingAnchor),
        trailingAnchor.constraint(equalTo: subview.trailingAnchor),

        subview.topAnchor.constraint(equalTo: topAnchor),
        bottomAnchor.constraint(equalTo: subview.bottomAnchor)
      ]
    )
  }
}

//MARK: Gradient
extension UIView {

    func applyGradient(isVertical: Bool, colorArray: [UIColor]) {
        layer.sublayers?.filter({ $0 is CAGradientLayer }).forEach({ $0.removeFromSuperlayer() })

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colorArray.map({ $0.cgColor })
        if isVertical {
            //top to bottom
            gradientLayer.locations = [0.0, 1.0]
        } else {
            //left to right
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }

        backgroundColor = .clear
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }

  func removeGradient() {
    layer.sublayers?.forEach({ subLayer in
      if subLayer is CAGradientLayer {
        subLayer.removeFromSuperlayer()
      }
    })
  }

}
