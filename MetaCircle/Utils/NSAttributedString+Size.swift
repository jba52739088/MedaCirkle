//
//  NSAttributedString+Size.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/14.
//

import Foundation
import UIKit

extension NSAttributedString {
  func rect(withConstrainedSize constrainSize: CGSize? = nil) -> CGRect {
    let size = constrainSize ?? CGSize(width: CGFloat.greatestFiniteMagnitude,
                                       height: CGFloat.greatestFiniteMagnitude)
    var boundingBox: CGRect {
      switch ProcessInfo().operatingSystemVersion {
      case let os where (os.majorVersion == 15):
        /// for iOS 15 system layout height issues
        return boundingRect(with: size,
                            options: [.usesLineFragmentOrigin],
                            context: nil)
      default:
        return boundingRect(with: size,
                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                            context: nil)
      }
    }
    return boundingBox.integral
  }

  func rect(withConstrainedHeight constrainHeight: CGFloat) -> CGRect {
    let constraintSize = CGSize(width: .greatestFiniteMagnitude, height: constrainHeight)
    return rect(withConstrainedSize: constraintSize)
  }

  func rect(withConstrainedWidth constrainWidth: CGFloat) -> CGRect {
    let constraintSize = CGSize(width: constrainWidth, height: .greatestFiniteMagnitude)
    return rect(withConstrainedSize: constraintSize)
  }

  func size(withConstrainedHeight constrainHeight: CGFloat) -> CGSize {
    return rect(withConstrainedHeight: constrainHeight).size
  }

  func size(withConstrainedWidth constrainWidth: CGFloat) -> CGSize {
    return rect(withConstrainedWidth: constrainWidth).size
  }

  func height(withConstrainedWidth constrainWidth: CGFloat) -> CGFloat {
    return rect(withConstrainedWidth: constrainWidth).height
  }

  func width(withConstrainedHeight constrainHeight: CGFloat) -> CGFloat {
    return rect(withConstrainedHeight: constrainHeight).width
  }
}
