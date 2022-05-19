//
//  UIView+Factory.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/18.
//

import Foundation
import ActiveLabel
import UIKit

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
}
