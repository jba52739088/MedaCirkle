//
//  TempCircleModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/8.
//

import UIKit

class TempCircleModel {

  enum PrivacyType {
    case WholePublic
    case HalfPublic
    case Private

    var image: UIImage? {
      switch self {
      case .WholePublic:
        return R.image.icon_privacy_public()
      case .HalfPublic:
        return R.image.icon_privacy_public()
      case .Private:
        return R.image.icon_privacy_public()
      }
    }
  }

  let image: UIImage?
  let title: String
  let subTitle: String
  let verified: Bool
  let badgeCount: Int
  let privacyType: PrivacyType

  init(image: UIImage?, title: String, subTitle: String, verified: Bool, badgeCount: Int, privacyType: PrivacyType) {
    self.image = image
    self.title = title
    self.subTitle = subTitle
    self.verified = verified
    self.badgeCount = badgeCount
    self.privacyType = privacyType
  }
}
