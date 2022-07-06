//
//  MemberInfoCellViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/3.
//

import UIKit
import RxSwift
import SwiftRichString

class MemberInfoCellViewModel: MemberCellViewModel {

  struct Theme {
    init() {
    }
  }

  let theme: Theme
//  let disposeBag = DisposeBag()

  init(theme: Theme = Theme()) {
    self.theme = theme
    super.init(type: .info)
  }

  override func cellHeight() -> CGFloat {
    return 94.f
  }

  var avatar: UIImage? {
    R.image.img_avatar_5()
  }

  var coinTitleAttributedString: NSAttributedString {
    return R.string.localizable.member_info_coin_title()
      .set(style: theme.titleTextStyle)
  }

  var friendTitleAttributedString: NSAttributedString {
    return R.string.localizable.member_info_friend_title()
      .set(style: theme.titleTextStyle)
  }

  var circleTitleAttributedString: NSAttributedString {
    return R.string.localizable.member_info_circle_title()
      .set(style: theme.titleTextStyle)
  }

  var coinCountTitleAttributedString: NSAttributedString {
    return "123"
      .set(style: theme.countTextStyle)
  }

  var friendCountTitleAttributedString: NSAttributedString {
    return "143"
      .set(style: theme.countTextStyle)
  }

  var circleCountTitleAttributedString: NSAttributedString {
    return "6"
      .set(style: theme.countTextStyle)
  }
}

extension MemberInfoCellViewModel.Theme {

  var titleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.promptRegular(size: 16)
      $0.maximumLineHeight = 25
      $0.minimumLineHeight = 25
      $0.color = UIColor.normalText
    }
  }

  var countTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.promptMedium(size: 22)
      $0.maximumLineHeight = 33
      $0.minimumLineHeight = 33
      $0.color = UIColor.normalText
    }
  }

}


