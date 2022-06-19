//
//  DynamicCollectionView.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/18.
//

import UIKit

class DynamicCollectionView: UICollectionView {
  override func layoutSubviews() {
    super.layoutSubviews()
    if bounds.size != intrinsicContentSize {
      invalidateIntrinsicContentSize()
    }
  }
  
  override var intrinsicContentSize: CGSize {
    return self.contentSize
  }
}
