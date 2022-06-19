//
//  ArticleTagItemViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/18.
//

import Foundation
import UIKit
import SwiftRichString

class ArticleTagItemViewModel: CollectionViewCellViewModel {

  var contentInsets: UIEdgeInsets = .zero
  func cellSize(for collectionViewSize: CGSize, containerInset: UIEdgeInsets) -> CGSize { .zero }

  let data: String

  init(data: String) {
    self.data = data
  }

  var titleAttributedString: NSAttributedString {
    return "<b>#</b>\(data)".set(style: titleTextStyle)
  }

  var titleTextStyle: StyleProtocol {
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
}
