//
//  CircleViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/14.
//

import UIKit
import SwiftRichString
import RxSwift
import RxRelay

class CircleViewModel {

  struct Theme {
    init() {
    }
  }
  let datasRelay = BehaviorRelay<[Int]>(value: [1])
//  let headerRelay: BehaviorRelay<CircleHeaderItemViewModel>
  let itemRelay = BehaviorRelay<[CircleSection]>(value: [])

  let data: TempCircleModel
  let theme: Theme

  init(data: TempCircleModel, theme: Theme = Theme()) {
    self.data = data
    self.theme = theme

    createVMs()
  }

  private func createVMs() {

    var items: [CircleArticleBaseItemViewModel] = []
    items.append(CircleArticleHeaderItemViewModel(data: data))
    items.append(CircleArticleTitleItemViewModel(data: data))
    items.append(CircleArticleItemViewModel(data: data))
    items.append(CircleArticleTagItemViewModel(data: data))
    itemRelay.accept([CircleSection(header: CircleArticleHeaderItemViewModel(data: data), items: items)])

  }
}
