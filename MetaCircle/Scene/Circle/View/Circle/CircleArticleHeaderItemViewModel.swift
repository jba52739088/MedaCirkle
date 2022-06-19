//
//  CircleHeaderItemViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/15.
//

import Foundation
import RxSwift
import SwiftRichString
import RxRelay

class CircleArticleHeaderItemViewModel: CircleArticleBaseItemViewModel {


  struct Theme { }

  let theme: Theme

  init(data: TempCircleModel, theme: Theme = Theme()) {
    self.theme = theme
    super.init(data: data, type: .header)
  }

  override func cellSize(for collectionViewSize: CGSize, containerInset: UIEdgeInsets) -> CGSize {
    return CGSize(width: 157, height: 70)
  }

  var authorAttributedString: NSAttributedString {
    return "Andy LIU"
      .set(style: theme.authorTextStyle)
  }

  var rankAttributedString: NSAttributedString {
    return "管理員"
      .set(style: theme.rankTextStyle)
  }

  var dateAttributedString: NSAttributedString {
    return "1.5小時"
      .set(style: theme.dateTextStyle)
  }

  var titleAttributedString: NSAttributedString {
    return "悲天憫人是人的天性。"
      .set(style: theme.titleTextStyle)
  }
}

extension CircleArticleHeaderItemViewModel.Theme {

  var authorTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCMedium(size: 15)
      $0.maximumLineHeight = 22
      $0.minimumLineHeight = 22
      $0.color = UIColor.normalText
      $0.alignment = .left
    }
  }

  var rankTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.promptRegular(size: 14)
      $0.maximumLineHeight = 21
      $0.minimumLineHeight = 21
      $0.color = UIColor.normalText
      $0.alignment = .left
    }
  }

  var dateTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.promptRegular(size: 14)
      $0.maximumLineHeight = 21
      $0.minimumLineHeight = 21
      $0.color = UIColor.timeGray
      $0.alignment = .left
    }
  }
  
  var titleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCMedium(size: 15)
      $0.maximumLineHeight = 22
      $0.minimumLineHeight = 22
      $0.color = UIColor.normalText
      $0.alignment = .left
    }
  }
}
