//
//  CircleContentCellViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/14.
//

import Foundation
import RxSwift
import SwiftRichString

class CircleContentCellViewModel: CircleContentBaseCellViewModel {

  override func cellHeight() -> CGFloat {
    return 374.f
  }

  struct Theme {
    init() {
    }
  }

  let theme: Theme

  init(data: TempCircleModel, theme: Theme = Theme()) {
    self.theme = theme
    super.init(data: data, type: .normal)

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
    return "面對AI介入設計，感覺二三十年前經歷過的事要重新再來ㄧ經歷過的要遍，面對AI介入設計，感覺二三十年前經歷過的事要重新再來來ㄧ來ㄧㄧ經AI..."
      .set(style: theme.contentTextStyle)
  }

  func tagAttributedString(_ text: String) -> NSAttributedString {
    return "<b>#</b>\(text)"
      .set(style: theme.tagTextStyle)
  }

  var readmoreAttributedString: NSAttributedString {
    return R.string.localizable.circle_content_read_more()
      .set(style: theme.readMoreTextStyle)
  }
}

extension CircleContentCellViewModel.Theme {

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
      $0.font = R.font.notoSansTCMedium(size: 26)
      $0.maximumLineHeight = 35
      $0.minimumLineHeight = 35
      $0.color = UIColor.normalText
      $0.alignment = .left
    }
  }

  var contentTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 15)
      $0.maximumLineHeight = 23
      $0.minimumLineHeight = 23
      $0.color = UIColor.normalText
      $0.alignment = .left
    }
  }

  var tagTextStyle: StyleProtocol {
    let style = Style {
      $0.font = R.font.promptRegular(size: 13)
      $0.maximumLineHeight = 19
      $0.minimumLineHeight = 19
      $0.color = UIColor.normalText
      $0.alignment = .center
    }

    let boldStyle = Style {
      $0.font = R.font.promptMedium(size: 13)
      $0.color = UIColor.tappableText
    }

    let group = StyleGroup(base: style, ["b": boldStyle])
    return group
  }

  var readMoreTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 16)
      $0.maximumLineHeight = 24
      $0.minimumLineHeight = 24
      $0.color = UIColor.tappableText
      $0.alignment = .left
    }
  }
}


