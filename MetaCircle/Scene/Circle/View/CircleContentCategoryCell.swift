//
//  CircleContnetCategoryCell.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/13.
//

import UIKit
import TinyConstraints

class CircleContentCategoryCell: CircleContentBaseCell {
  let container = UIView().then {
    $0.backgroundColor = .normalLightBg
  }

  let categorys: [UIButton] = [UIButton(type: .custom), UIButton(type: .custom), UIButton(type: .custom)]

  override func setup() {
    self.backgroundColor = .clear
    self.selectionStyle = .none

    container.do {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
      $0.height(43, relation: .equalOrGreater)
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.bottomToSuperview()
    }

    UIView().do {
      container.addSubview($0)
      $0.height(1)
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.bottomToSuperview()
      $0.backgroundColor = .separator
    }

  }

  override func layoutSubviews() {
    super.layoutSubviews()

  }

  override func didUpdate(viewModel: CircleContentBaseCellViewModel?) {
    guard let viewModel = viewModel as? CircleContentTopCellViewModel else { return }
//    avatarImgView.image = viewModel.data.image
//    privacyImgView.image = viewModel.data.privacyType.image
//    titleLabel.attributedText = viewModel.titleAttributedString
//    albumButton.setAttributedTitle(viewModel.albumAttributedString, for: .normal)
//    calendarButton.setAttributedTitle(viewModel.calendarAttributedString, for: .normal)
//    fileButton.setAttributedTitle(viewModel.filesAttributedString, for: .normal)
//    introButton.setAttributedTitle(viewModel.introAttributedString, for: .normal)
  }
}

private
extension CircleContentCategoryCell {

}


