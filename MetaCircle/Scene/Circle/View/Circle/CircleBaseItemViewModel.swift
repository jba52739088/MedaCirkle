//
//  CircleBaseItemViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/15.
//

import Foundation
import UIKit

class CircleBaseItemViewModel: CollectionViewCellViewModel {
    
    var contentInsets: UIEdgeInsets = .zero
    func cellSize(for collectionViewSize: CGSize, containerInset: UIEdgeInsets) -> CGSize { .zero }
    
    enum CellType {
        case header
        case content
        case reply
    }
    
    let data: TempCircleModel
    let type: CellType
    
    init(data: TempCircleModel, type: CellType) {
        self.data = data
        self.type = type
    }
}



