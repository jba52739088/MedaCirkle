//
//  CircleArticleItemViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/18.
//

import Foundation
import RxSwift
import SwiftRichString
import RxRelay

class CircleArticleItemViewModel: CircleArticleBaseItemViewModel {

  struct Theme { }

  let theme: Theme
  let itemRelay = BehaviorRelay<[String]>(value: ["設計", "比賽", "社團活動", "社團活動"])

  init(data: TempCircleModel, theme: Theme = Theme()) {
    self.theme = theme
    super.init(data: data, type: .title)
  }

  override func cellSize(for collectionViewSize: CGSize, containerInset: UIEdgeInsets) -> CGSize {
    return CGSize(width: 157, height: 70)
  }

  var contentAttributedString: NSAttributedString {
    return "面對AI介入設計，大大大文字樣式，但平時可以拿來放在櫃子上面，掛帽子也適合。\n\n中中中中中文字，用戶調研遇到了一些整合性效率的問題，急需能足活極，在業健不為爸說！\n\n小小小小小小文字，一篇😃梗圖圖文，一篇補給包文章，週會十知入人白是溫帶超企好將……費省少？金藝我，樹重後小緊了專還走求得強中引空觀港委問足要市！\n\n1.辦公室面對面諮詢\n 一篇😃梗圖圖文，一篇補給包文章，週會十知入人白是溫帶超企好將……費省少？金藝我，樹重後小緊了專還走求得強中引空觀港委問足要市！"
      .set(style: theme.contentTextStyle)
  }
}

extension CircleArticleItemViewModel.Theme {

  var contentTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 15)
      $0.maximumLineHeight = 23
      $0.minimumLineHeight = 23
      $0.color = UIColor.normalText
      $0.alignment = .left
    }
  }
}


