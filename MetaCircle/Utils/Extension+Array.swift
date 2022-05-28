//
//  Extension+Array.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/25.
//

import Foundation

extension Collection {
  internal subscript (safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}
