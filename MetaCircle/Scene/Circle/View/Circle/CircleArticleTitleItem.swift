//
//  CircleTitleItem.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/15.
//

import UIKit
import TinyConstraints

class CircleArticleTitleItem: CircleArticleBaseItem {
  let container = UIView().then {
    $0.backgroundColor = .normalLightBg
  }

  let titleLabel = UILabel().then {
    $0.numberOfLines = 0
  }

  override func setup() {
    self.backgroundColor = .clear

    container.do {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.bottomToSuperview()
      $0.width(UIScreen.main.bounds.width)
    }

    titleLabel.do {
      container.addSubview($0)
      $0.leftToSuperview(offset: 20)
      $0.rightToSuperview(offset: -20)
      $0.topToSuperview(offset: 15)
      $0.bottomToSuperview(offset: -20)
    }
  }

  override func layoutSubviews() {
    super.layoutSubviews()
  }

  override func didUpdate(viewModel: CircleArticleBaseItemViewModel?) {
    guard let viewModel = viewModel as? CircleArticleTitleItemViewModel else { return }
    titleLabel.attributedText = viewModel.titleAttributedString
  }
}

