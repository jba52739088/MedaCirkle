//
//  CircleArticleBaseItem.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/15.
//

import UIKit
import TinyConstraints
import RxDataSources

class CircleArticleBaseItem: CollectionViewCell<CircleArticleBaseItemViewModel> {
  
  override func setup() {
    
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
  }
  
  override func didUpdate(viewModel: CircleArticleBaseItemViewModel?) {
    guard let viewModel = viewModel else { return }
    
  }
}

struct CircleSection {
  var header: CircleArticleHeaderItemViewModel
  var items: [CircleArticleBaseItemViewModel]
}

extension CircleSection: SectionModelType {

  typealias Item = CircleArticleBaseItemViewModel

  init(original: CircleSection, items: [CircleArticleBaseItemViewModel]) {
    self = original
    self.items = items
  }
}
