//
//  Extension+UIImage.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/29.
//

import Foundation
import UIKit

extension UIImage {
  
  static func withColor(_ color: UIColor, size: CGSize = .init(width: 1, height: 1)) -> UIImage? {
    let rect = CGRect(origin: .zero, size: size)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()

    context?.setFillColor(color.cgColor)
    context?.fill(rect)

    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return image
  }

}
