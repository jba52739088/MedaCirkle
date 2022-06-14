//
//  CircleContentViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/29.
//

import UIKit
import SwiftRichString
import RxCocoa


class CircleContentViewModel {

  struct Theme {
    init() {
    }
  }

  var cellVMsRelay = BehaviorRelay<[CircleContentBaseCellViewModel]>(value: [])

  let data: TempCircleModel
  let theme: Theme
  init(data: TempCircleModel, theme: Theme = Theme()) {
    self.data = data
    self.theme = theme


    cellVMsRelay.accept([CircleContentTopCellViewModel(data: data),
                         CircleContentCategoryCellViewModel(data: data),
                         CircleContentPinCellViewModel(data: data),
                         CircleContentCellViewModel(data: data),
                         CircleContentCellViewModel(data: data),
                         CircleContentCellViewModel(data: data),
                         CircleContentCellViewModel(data: data),
                         CircleContentCellViewModel(data: data),
                         CircleContentCellViewModel(data: data),
                         CircleContentCellViewModel(data: data)])

  }

}
