//
//  CircleArticleTagItemViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/18.
//

import Foundation
import RxSwift
import RxRelay

class CircleArticleTagItemViewModel: CircleArticleBaseItemViewModel {

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

}

