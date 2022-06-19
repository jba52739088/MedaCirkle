//
//  CircleTitleItemViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/15.
//

import Foundation
import RxSwift
import SwiftRichString
import RxRelay

class CircleArticleTitleItemViewModel: CircleArticleBaseItemViewModel {

  struct Theme { }

  let theme: Theme

  init(data: TempCircleModel, theme: Theme = Theme()) {
    self.theme = theme
    super.init(data: data, type: .title)
  }

  override func cellSize(for collectionViewSize: CGSize, containerInset: UIEdgeInsets) -> CGSize {
    return CGSize(width: 157, height: 70)
  }

  var titleAttributedString: NSAttributedString {
    return "悲天憫人是人的天性。"
      .set(style: theme.titleTextStyle)
  }
}

extension CircleArticleTitleItemViewModel.Theme {

  var titleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCMedium(size: 32)
      $0.maximumLineHeight = 47
      $0.minimumLineHeight = 47
      $0.color = UIColor.normalText
      $0.alignment = .left
    }
  }
}


