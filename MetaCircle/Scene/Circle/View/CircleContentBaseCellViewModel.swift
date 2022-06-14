//
//  CircleContentCellViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/10.
//

import Foundation
import RxSwift
import SwiftRichString

class CircleContentBaseCellViewModel: TableViewCellViewModel {

  enum CellType {
    case top
    case category
    case pin
    case normal
  }
  
  func cellHeight() -> CGFloat {
    return 0
  }

  let data: TempCircleModel
  let type: CellType

  init(data: TempCircleModel, type: CellType) {
    self.data = data
    self.type = type
  }

}


