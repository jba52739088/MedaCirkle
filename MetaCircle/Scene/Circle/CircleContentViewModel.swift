//
//  CircleContentViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/29.
//

import UIKit
import SwiftRichString
import RxCocoa


class CircleContentViewModel {

  let type: Theme.PageType
  var dataRelay = BehaviorRelay<[TempCircleModel]>(value: [])

  struct Theme {
    init() {
    }
  }

  let theme: Theme
  init(type: Theme.PageType) {
    self.theme = Theme()
    self.type = type

    let datas = type == .Joined ? self.tempJoinedDatas() : self.tempCreatedDatas()
    self.dataRelay.accept(datas)
  }

  var joinedCountAttributedString: NSAttributedString {
    return R.string.localizable.circle_vc_joined_count_label(String(dataRelay.value.count))
      .set(style: theme.joinedCountTextStyle)
  }

  var sortLabelAttributedString: NSAttributedString {
    return R.string.localizable.circle_vc_sort_button()
      .set(style: theme.sortTextStyle)
  }
}

extension CircleContentViewModel {
  private func tempJoinedDatas() -> [TempCircleModel] {
    return [TempCircleModel(image: R.image.img_circle_avatar_1(), title: "幸福幸福私立大學", subTitle: "成員1.2K人", verified: true, badgeCount: 1200, privacyType: .WholePublic),
            TempCircleModel(image: R.image.img_circle_avatar_2(), title: "鏟屎官貓貓用品百貨", subTitle: "成員1.2K人", verified: true, badgeCount: 999, privacyType: .WholePublic),
            TempCircleModel(image: R.image.img_circle_avatar_3(), title: "平面設計長文裝設文裝", subTitle: "成員1.2K人", verified: true, badgeCount: 99, privacyType: .WholePublic),
            TempCircleModel(image: R.image.img_circle_avatar_4(), title: "自行車愛好", subTitle: "成員523人", verified: false, badgeCount: 1, privacyType: .HalfPublic),
            TempCircleModel(image: R.image.img_circle_avatar_5(), title: "自行車愛好2", subTitle: "成員524人", verified: false, badgeCount: 333333, privacyType: .Private),
            TempCircleModel(image: R.image.img_circle_avatar_6(), title: "自行車愛好3", subTitle: "成員525人", verified: false, badgeCount: 0, privacyType: .Private),
            TempCircleModel(image: R.image.img_circle_avatar_7(), title: "自行車愛好4", subTitle: "成員526人", verified: false, badgeCount: 0, privacyType: .Private),
            TempCircleModel(image: R.image.img_circle_avatar_1(), title: "自行車愛好5", subTitle: "成員527人", verified: true, badgeCount: 5, privacyType: .Private),
            TempCircleModel(image: R.image.img_circle_avatar_3(), title: "自行車愛好6", subTitle: "成員528人", verified: true, badgeCount: 0, privacyType: .HalfPublic),
            TempCircleModel(image: R.image.img_circle_avatar_5(), title: "自行車愛好7", subTitle: "成員529人", verified: false, badgeCount: 0, privacyType: .HalfPublic),
            TempCircleModel(image: R.image.img_circle_avatar_7(), title: "自行車愛好8", subTitle: "成員530人", verified: false, badgeCount: 5, privacyType: .WholePublic),
            TempCircleModel(image: R.image.img_circle_avatar_2(), title: "自行車愛好9", subTitle: "成員531人", verified: false, badgeCount: 5, privacyType: .WholePublic)]
  }

  private func tempCreatedDatas() -> [TempCircleModel] {
    return [TempCircleModel(image: R.image.img_circle_avatar_1(), title: "幸福幸福私立大學", subTitle: "成員1.2K人", verified: true, badgeCount: 2, privacyType: .WholePublic),
            TempCircleModel(image: R.image.img_circle_avatar_2(), title: "鏟屎官貓貓用品百貨", subTitle: "成員1.2K人", verified: true, badgeCount: 6, privacyType: .WholePublic),
            TempCircleModel(image: R.image.img_circle_avatar_3(), title: "平面設計長文裝設文裝", subTitle: "成員1.2K人", verified: true, badgeCount: 1, privacyType: .WholePublic),
            TempCircleModel(image: R.image.img_circle_avatar_4(), title: "自行車愛好", subTitle: "成員523人", verified: false, badgeCount: 0, privacyType: .HalfPublic)]
  }
}

extension CircleContentViewModel.Theme {

  enum PageType {
    case Joined
    case Created
  }

  var joinedCountTextStyle: StyleProtocol {
    let style = Style {
      $0.font = R.font.notoSansTCRegular(size: 16)
      $0.maximumLineHeight = 24
      $0.minimumLineHeight = 24
      $0.color = UIColor.normalText
      $0.alignment = .left
    }

    let boldStyle = Style {
      $0.font = R.font.promptMedium(size: 16)
      $0.color = UIColor.normalText
    }

    let group = StyleGroup(base: style, ["b": boldStyle])
    return group
  }

  var sortTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 16)
      $0.maximumLineHeight = 24
      $0.minimumLineHeight = 24
      $0.color = UIColor.black
    }
  }

}

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
