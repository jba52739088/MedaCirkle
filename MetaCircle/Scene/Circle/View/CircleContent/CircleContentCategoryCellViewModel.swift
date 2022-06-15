//
//  CircleContnetCategoryCellViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/13.
//

import Foundation
import RxSwift
import SwiftRichString

class CircleContentCategoryCellViewModel: CircleContentBaseCellViewModel {

  override func cellHeight() -> CGFloat {
    return 43.f
  }

  struct Theme {
    init() {
    }
  }

  let theme: Theme

  init(data: TempCircleModel, theme: Theme = Theme()) {
    self.theme = theme
    super.init(data: data, type: .category)

  }

  
  func titleAttributedString(text: String) -> NSAttributedString {
    return text.set(style: theme.categoryButtonTextStyle)
  }
}

extension CircleContentCategoryCellViewModel.Theme {

  var categoryButtonTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCMedium(size: 16)
      $0.minimumLineHeight = 24
      $0.maximumLineHeight = 24
      $0.color = UIColor.normalText
      $0.alignment = .center
    }
  }
}


