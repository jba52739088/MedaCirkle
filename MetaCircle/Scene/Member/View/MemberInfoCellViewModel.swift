//
//  MemberInfoCellViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/3.
//

import UIKit
import RxSwift
import SwiftRichString

class MemberInfoCellViewModel: TableViewCellViewModel {

  struct Theme {
    init() {
    }
  }

  let theme: Theme
  let profile: Profile
//  let disposeBag = DisposeBag()

  init(profile: Profile, theme: Theme = Theme()) {
    self.profile = profile
    self.theme = theme
  }

  func cellHeight() -> CGFloat {
    return 94.f
  }

  var avatar: UIImage? {
    R.image.img_avatar_5()
  }

  var nickNameAttributedString: NSAttributedString {
    return (profile.nickname ?? "")
      .set(style: theme.nickNameTextStyle)
  }

  var nameAttributedString: NSAttributedString {
    return (profile.name ?? "")
      .set(style: theme.nickNameTextStyle)
  }

  var editAttributedString: NSAttributedString {
    return (profile.name ?? "")
      .set(style: theme.nickNameTextStyle)
  }


}

extension MemberInfoCellViewModel.Theme {

  var nickNameTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.promptSemiBold(size: 22)
      $0.maximumLineHeight = 33
      $0.minimumLineHeight = 33
      $0.color = UIColor.normalText
    }
  }

  var nameTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 18)
      $0.maximumLineHeight = 27
      $0.minimumLineHeight = 27
      $0.color = UIColor.normalText
    }
  }

  var editTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCMedium(size: 16)
      $0.maximumLineHeight = 24
      $0.minimumLineHeight = 24
      $0.color = UIColor.tappableText
    }
  }

}


