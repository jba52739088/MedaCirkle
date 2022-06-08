//
//  TopicFeatureItemViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/8.
//

import Foundation
import RxSwift
import SwiftRichString

class TopicFeatureItemViewModel: CollectionViewCellViewModel {


  struct Theme { }

  var contentInsets: UIEdgeInsets

  let theme: Theme
  let data: TempTopicFeature
  var isChoose: Bool

  init(data: TempTopicFeature, isChoose: Bool, theme: Theme = Theme()) {
    contentInsets = .zero
    self.data = data
    self.isChoose = isChoose
    self.theme = theme
  }

  func cellSize(for collectionViewSize: CGSize, containerInset: UIEdgeInsets) -> CGSize {
    return CGSize(width: 157, height: 70)
  }

  var titleAttributedString: NSAttributedString {
    return data.title
      .set(style: theme.titleTextStyle)
  }
}

extension TopicFeatureItemViewModel.Theme {


  var titleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 17)
      $0.maximumLineHeight = 25
      $0.minimumLineHeight = 25
      $0.color = UIColor.normalText
      $0.alignment = .left
    }
  }
}


