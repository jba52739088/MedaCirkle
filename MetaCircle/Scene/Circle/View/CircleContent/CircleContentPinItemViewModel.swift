//
//  CircleContentPinItemViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/14.
//

import Foundation
import RxSwift
import SwiftRichString

class CircleContentPinItemViewModel: CollectionViewCellViewModel {


  struct Theme { }

  var contentInsets: UIEdgeInsets

  let theme: Theme

  init(theme: Theme = Theme()) {
    contentInsets = .zero
    self.theme = theme
  }

  func cellSize(for collectionViewSize: CGSize, containerInset: UIEdgeInsets) -> CGSize {
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

  var contentAttributedString: NSAttributedString {
    return "面對AI介入設計，感覺二三十年前經歷過的事要重新再來ㄧ經歷過的要遍..."
      .set(style: theme.contentTextStyle)
  }
}

extension CircleContentPinItemViewModel.Theme {

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
      $0.font = R.font.notoSansTCMedium(size: 24)
      $0.maximumLineHeight = 30
      $0.minimumLineHeight = 30
      $0.color = UIColor.normalText
      $0.alignment = .left
    }
  }

  var contentTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 18)
      $0.maximumLineHeight = 26
      $0.minimumLineHeight = 26
      $0.color = UIColor.normalText
      $0.alignment = .left
    }
  }

}


