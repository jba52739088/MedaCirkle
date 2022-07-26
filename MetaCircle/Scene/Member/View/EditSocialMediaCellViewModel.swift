//
//  EditSocialMediaCellViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/20.
//

import Foundation
import SwiftRichString

class EditSocialMediaCellViewModel: TableViewCellViewModel {

  struct Theme {
    init() {
    }
  }

  let theme: Theme
  let type: SocialMedia

  init(type: SocialMedia, theme: Theme = Theme()) {
    self.type = type
    self.theme = theme
  }

  func cellHeight() -> CGFloat {
    return 64.f
  }

  var titleAttributedString: NSAttributedString {
    return type.title
      .set(style: theme.titleTextStyle)
  }

  var buttonAttributedString: NSAttributedString {
    return R.string.localizable.profile_edit_social_media_add()
      .set(style: theme.buttonTextStyle)
  }

}

extension EditSocialMediaCellViewModel.Theme {


  var titleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.promptRegular(size: 18)
      $0.maximumLineHeight = 28
      $0.minimumLineHeight = 28
      $0.color = UIColor.normalText
    }
  }

  var buttonTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCMedium(size: 15)
      $0.maximumLineHeight = 22
      $0.minimumLineHeight = 22
      $0.color = UIColor.normalLightBg
    }
  }


}



