//
//  CircleBaseItem.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/15.
//

import UIKit
import TinyConstraints

class CircleBaseItem: CollectionViewCell<CircleBaseItemViewModel> {

  override func setup() {

  }

  override func layoutSubviews() {
    super.layoutSubviews()

  }

  override func didUpdate(viewModel: CircleBaseItemViewModel?) {
    guard let viewModel = viewModel else { return }

  }
}
