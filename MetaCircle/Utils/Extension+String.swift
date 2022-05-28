//
//  Extension+String.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/24.
//

import UIKit

extension String {
  
  func subString(from: Int, to: Int) -> String {
    let startIndex = self.index(self.startIndex, offsetBy: from)
    let endIndex = self.index(self.startIndex, offsetBy: to)
    return String(self[startIndex..<endIndex])
  }
}
