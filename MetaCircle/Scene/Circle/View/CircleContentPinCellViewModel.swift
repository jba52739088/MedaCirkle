//
//  CircleContentPinCellViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/14.
//

import Foundation
import RxSwift
import SwiftRichString
import RxRelay

class CircleContentPinCellViewModel: CircleContentBaseCellViewModel {

  override func cellHeight() -> CGFloat {
    return 448.f
  }

  struct Theme {
    init() {
    }
  }

  let datasRelay = BehaviorRelay<[Int]>(value: [1,2,3,4])
  let theme: Theme

  init(data: TempCircleModel, theme: Theme = Theme()) {
    self.theme = theme
    super.init(data: data, type: .pin)

  }


  var titleAttributedString: NSAttributedString {
    return R.string.localizable.circle_content_category_pin().set(style: theme.titleTextStyle)
  }
}

extension CircleContentPinCellViewModel.Theme {

  var titleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 18)
      $0.minimumLineHeight = 20
      $0.maximumLineHeight = 20
      $0.color = UIColor.normalText
      $0.alignment = .left
    }
  }
}


