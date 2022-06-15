//
//  CircleViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/14.
//

import UIKit
import SwiftRichString


class CircleViewModel {

  struct Theme {
    init() {
    }
  }

  let theme: Theme
  init(theme: Theme = Theme()) {
    self.theme = theme
  }
  
}
