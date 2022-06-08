//
//  TempTopicModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/8.
//

import UIKit

class TempTopicModel {

  let image: UIImage?
  let title: String
  let subType: [TempTopicFeature]

  init(image: UIImage?, title: String, subType: [TempTopicFeature]) {
    self.image = image
    self.title = title
    self.subType = subType
  }
}

class TempTopicFeature {

  let title: String

  init(title: String) {
    self.title = title
  }
}

