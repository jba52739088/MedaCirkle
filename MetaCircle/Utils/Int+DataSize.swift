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

