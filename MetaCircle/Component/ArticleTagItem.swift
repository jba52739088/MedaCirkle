//
//  ArticleTagItem.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/18.
//

import UIKit
import TinyConstraints
import RxDataSources

protocol ArticleTagItemDelegate: AnyObject {
  func onClickTag(in view: ArticleTagItem)
}

class ArticleTagItem: CollectionViewCell<ArticleTagItemViewModel> {

  weak var delegate: ArticleTagItemDelegate?

  let container = UIView().then {
    $0.backgroundColor = .tagBlue
  }

  let tagButton = UIButton(type: .custom)

  override func setup() {
    self.backgroundColor = .clear

    container.do {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.bottomToSuperview()
      $0.backgroundColor = .tagBlue
    }

    tagButton.do {
      container.addSubview($0)
      $0.height(26)
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.bottomToSuperview()
      $0.contentEdgeInsets = UIEdgeInsets(top: 3, left: 16, bottom: 3, right: 16)
//      $0.backgroundColor = .tagBlue
//      $0.titleLabel?.adjustsFontSizeToFitWidth = true
    }
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    container.layer.cornerRadius = 13
    container.layer.masksToBounds = true
  }

  override func didUpdate(viewModel: ArticleTagItemViewModel?) {
    guard let viewModel = viewModel else { return }
    tagButton.setAttributedTitle(viewModel.titleAttributedString, for: .normal)
//    tagButton.sizeToFit()
  }

  @objc
  private func onClickButton() {
    self.delegate?.onClickTag(in: self)
  }
}

