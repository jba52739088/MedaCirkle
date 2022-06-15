//
//  CircleViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/14.
//

import UIKit
import SwiftRichString
import RxSwift
import RxRelay


class CircleViewModel {

  struct Theme {
    init() {
    }
  }
    let datasRelay = BehaviorRelay<[Int]>(value: [1])

  let theme: Theme
  init(theme: Theme = Theme()) {
    self.theme = theme
  }
  
}
