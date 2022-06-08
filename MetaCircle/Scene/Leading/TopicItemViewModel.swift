//
//  TopicItemViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/8.
//

import Foundation
import RxSwift
import SwiftRichString

class TopicItemViewModel: CollectionViewCellViewModel {


  struct Theme { }

  var contentInsets: UIEdgeInsets

  let theme: Theme
  let data: TempTopicModel
  var isChoose: Bool

  init(data: TempTopicModel, isChoose: Bool, theme: Theme = Theme()) {
    contentInsets = .zero
    self.data = data
    self.isChoose = isChoose
    self.theme = theme
  }

  func cellSize(for collectionViewSize: CGSize, containerInset: UIEdgeInsets) -> CGSize {
    return CGSize(width: 96, height: 101)
  }

  var titleAttributedString: NSAttributedString {
    return data.title
      .set(style: theme.titleTextStyle)
  }

  func badgeAttributedString(_ count: Int) -> NSAttributedString {
    return "\(count)".set(style: theme.bagdeTextStyle)
  }
}

extension TopicItemViewModel.Theme {

  var titleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 16)
      $0.maximumLineHeight = 24
      $0.minimumLineHeight = 24
      $0.color = UIColor.normalText
      $0.alignment = .center
    }
  }

  var bagdeTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.promptMedium(size: 13)
      $0.maximumLineHeight = 19
      $0.minimumLineHeight = 19
      $0.color = UIColor.normalLightBg
      $0.alignment = .center
    }
  }
}


