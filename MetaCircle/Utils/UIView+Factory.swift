//
//  UIView+Factory.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/18.
//

import Foundation
import ActiveLabel
import UIKit
import SwiftRichString

typealias VoidBlock = () -> Void

extension UIView {

  static func normalActivleLabel(
    tappableText: String,
    originalText: NSAttributedString,
    tappableColor: UIColor,
    action: @escaping VoidBlock) -> ActiveLabel {

      return ActiveLabel().then {
        $0.numberOfLines = 1
        $0.lineBreakMode = .byWordWrapping
        $0.textColor = .black
        $0.textAlignment = .left
        let customType = ActiveType.custom(pattern: "\\\(tappableText)\\b")
        $0.enabledTypes = [customType]
        $0.customize { label in
          label.attributedText = originalText
          label.customColor[customType] = tappableColor
          label.handleCustomTap(for: customType) { text in
            if text == tappableText {
              action()
            }
          }
        }
      }
    }

  static func searchBarButton(target: Any? = nil,  action: Selector? = nil) -> UIButton {
    let backButton = UIButton(type: .custom).then {
      $0.setImage(R.image.icon_searchbar_search_w20(), for: .normal)
      $0.imageEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
      $0.imageView?.contentMode = .scaleAspectFit
    }
    backButton.addNormalTouch(target, action: action)
    return backButton
  }


  static func backButton(target: Any? = nil,  action: Selector? = nil) -> UIButton {
    let backButton = UIButton(type: .custom).then {
      $0.setImage(R.image.icon_arrow_left_w10_h16(), for: .normal)
      $0.imageEdgeInsets = UIEdgeInsets(top: 8.53, left: 0, bottom: 8.53, right: 0)
      $0.imageView?.contentMode = .scaleAspectFit
    }
    backButton.addNormalTouch(target, action: action)
    return backButton
  }

  static func searchButton(target: Any? = nil,  action: Selector? = nil) -> UIButton {
    let backButton = UIButton(type: .custom).then {
      $0.setImage(R.image.icon_search_w22(), for: .normal)
      $0.imageEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
      $0.imageView?.contentMode = .scaleAspectFit
    }
    backButton.addNormalTouch(target, action: action)
    return backButton
  }

  static func menuButton(target: Any? = nil,  action: Selector? = nil) -> UIButton {
    let backButton = UIButton(type: .custom).then {
      $0.setImage(R.image.icon_more_1_w16(), for: .normal)
      $0.imageEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
      $0.imageView?.contentMode = .scaleAspectFit
    }
    backButton.addNormalTouch(target, action: action)
    return backButton
  }

  static func bellButton(target: Any? = nil,  action: Selector? = nil) -> UIButton {
    let backButton = UIButton(type: .custom).then {
      $0.setImage(R.image.icon_header_bell(), for: .normal)
      $0.imageEdgeInsets = .zero
      $0.imageView?.contentMode = .scaleAspectFit
    }
    backButton.addNormalTouch(target, action: action)
    return backButton
  }
    
    static func closeButton(target: Any? = nil,  action: Selector? = nil) -> UIButton {
      let backButton = UIButton(type: .custom).then {
        $0.setImage(R.image.icon_close_1_w14(), for: .normal)
        $0.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        $0.imageView?.contentMode = .scaleAspectFit
      }
      backButton.addNormalTouch(target, action: action)
      return backButton
    }

  static func normalSubmitButton(title: String? = nil, target: Any? = nil,  action: Selector? = nil) -> UIButton {
    let button = UIButton(type: .custom)
    let _title = title ?? R.string.localizable.confirm()
    button.setAttributedTitle(_title.set(style: UIView.enableLoginTextStyle), for: .normal)
    button.setAttributedTitle(_title.set(style: UIView.disableLoginTextStyle), for: .disabled)
    button.addNormalTouch(target, action: action)
    button.isEnabled = false
    button.setBackgroundColor(.btnBlue, forState: .normal)
    button.setBackgroundColor(.btnGray, forState: .disabled)
    return button
  }

  static func circleContentButton(target: Any? = nil,  action: Selector? = nil) -> UIButton {
    let backButton = UIButton(type: .custom).then {
      $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -3, bottom: 0, right: 3)
      $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: -3)
      $0.imageView?.contentMode = .scaleAspectFit
    }
    backButton.addNormalTouch(target, action: action)
    return backButton
  }
}

// MARK: - Buttons
private extension UIButton {

  func addNormalTouch(_ target: Any? = nil, action: Selector? = nil) {
    action.map { self.addTarget(target, action: $0, for: .touchUpInside) }
  }

  func setBackgroundColor(_ color: UIColor, forState controlState: UIControl.State) {
    let colorImage = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1)).image { _ in
      color.setFill()
      UIBezierPath(rect: CGRect(x: 0, y: 0, width: 1, height: 1)).fill()
    }
    setBackgroundImage(colorImage, for: controlState)
  }
}

// MARK: - Style
extension UIView {
  static var enableLoginTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 17)
      $0.maximumLineHeight = 25
      $0.minimumLineHeight = 25
      $0.color = UIColor.white
    }
  }

  static var disableLoginTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 17)
      $0.maximumLineHeight = 25
      $0.minimumLineHeight = 25
      $0.color = UIColor.placeholderColor
    }
  }
}
