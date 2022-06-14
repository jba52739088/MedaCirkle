//
//  CircleCellViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/31.
//

import Foundation
import RxSwift
import SwiftRichString

class CircleCellViewModel: TableViewCellViewModel {

  struct Theme {
    init() {
    }
  }

  let theme: Theme
  let data: TempCircleModel
//  let disposeBag = DisposeBag()

  init(data: TempCircleModel, theme: Theme = Theme()) {
    self.data = data
    self.theme = theme
  }

  func cellHeight() -> CGFloat {
    return 80.f
  }
  
  var titleAttributedString: NSAttributedString {
    return data.title
      .set(style: theme.titleTextStyle)
  }

  var subTitleAttributedString: NSAttributedString {
    return data.subTitle
      .set(style: theme.subtitleTextStyle)
  }

  var bedgeAttributedString: NSAttributedString {
    return data.badgeCount.formatPoints
      .set(style: theme.bedgeTextStyle)
  }
}

extension CircleCellViewModel.Theme {


  var titleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCMedium(size: 17)
      $0.maximumLineHeight = 25
      $0.minimumLineHeight = 25
      $0.color = UIColor.normalText
    }
  }

  var subtitleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 14)
      $0.maximumLineHeight = 20
      $0.minimumLineHeight = 20
      $0.color = UIColor.categoryTextGray
    }
  }

  var bedgeTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.promptMedium(size: 14)
      $0.maximumLineHeight = 21
      $0.minimumLineHeight = 21
      $0.color = UIColor.normalLightBg
      $0.alignment = .center
    }
  }

}


