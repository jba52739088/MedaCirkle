//
//  Int+DataSize.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/17.
//

import UIKit

extension Int {
  internal var gigabyte: Int {
    return self * 1024 * 1024 * 1024
  }

  internal var megaByte: Int {
    return self * 1024 * 1024
  }

  internal var kiloByte: Int {
    return self * 1024
  }

  internal var f: CGFloat {
    return CGFloat(self)
  }

  internal var d: Double {
    return Double(self)
  }
}

extension Int {
  var formatPoints: String {
    let number = Double(self)
    let thousand = number / 1000
    let million = number / 1000000
    if million >= 1.0 {
      return "\(round(million*10)/10)M"
    }
    else if thousand >= 1.0 {
      return "\(round(thousand*10)/10)K"
    }
    else if self == 0 {
      return ""
    }
    else {
      return "\(self)"
    }
  }
}
