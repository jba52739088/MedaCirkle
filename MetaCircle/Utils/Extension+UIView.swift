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

  func normalBackgroundGradient() {
    self.applyGradient(isVertical: false, colorArray: [.backgroundGradientYellow, .backgroundGradientPurple, .backgroundGradientBlue])
  }

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

  func circleGradient() {
    layer.sublayers?.filter({ $0 is CAGradientLayer }).forEach({ $0.removeFromSuperlayer() })

    let gradient = CAGradientLayer()
    gradient.frame =  CGRect(origin: CGPoint.zero, size: frame.size)
    gradient.colors = [UIColor.tabbarGradientYellow.cgColor,
                       UIColor.tabbarGradientPurple.cgColor,
                       UIColor.tabbarGradientBlue.cgColor]
    gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
    gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
    gradient.cornerRadius = frame.width / 2
    gradient.opacity = 0.5

    let shape = CAShapeLayer()
    shape.lineWidth = 2
    shape.path = UIBezierPath(roundedRect: bounds.insetBy(dx: 1, dy: 1), cornerRadius: frame.width / 2).cgPath
    shape.strokeColor = UIColor.black.cgColor
    shape.fillColor = UIColor.clear.cgColor
    shape.cornerRadius = frame.width / 2
    gradient.mask = shape

    clipsToBounds = true
    layer.cornerRadius = frame.width / 2
    layer.addSublayer(gradient)
  }

  func circleInnerShadow() {
//    layer.shadowColor = UIColor.black.cgColor
//    layer.shadowOpacity = 0.5
//    layer.shadowOffset = CGSize(width: -2, height: -5)
//    layer.shadowRadius = 6
//    layer.masksToBounds = false
//    clipsToBounds = true
  }
}

//MARK: Shadow
extension UIView {
  func addShadow(location: VerticalLocation, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
    switch location {
    case .bottom:
      addShadow(offset: CGSize(width: 0, height: 4), color: color, opacity: opacity, radius: radius - 4)
    case .top:
      addShadow(offset: CGSize(width: 0, height: -4), color: color, opacity: opacity, radius: radius - 4)
    }
  }

  func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
    self.layer.masksToBounds = false
    self.layer.shadowColor = color.cgColor
    self.layer.shadowOffset = offset
    self.layer.shadowOpacity = opacity
    self.layer.shadowRadius = radius
  }
}
