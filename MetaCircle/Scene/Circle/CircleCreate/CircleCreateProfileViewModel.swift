//
//  CircleCreateProfileViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/3.
//

import UIKit
import SwiftRichString

class CircleCreateProfileViewModel {

  struct Theme {
    init() {
    }
  }

  let theme: Theme
  init(theme: Theme = Theme()) {
    self.theme = theme
  }

  var titleAttributedString: NSAttributedString {
    return R.string.localizable.circle_create_vc_title()
      .set(style: theme.titleTextStyle)
  }

  var nextButtonNormalAttributedString: NSAttributedString {
    return R.string.localizable.circle_create_vc_add_button()
      .set(style: theme.nextButtonNormalTextStyle)
  }

  var nextButtonHighlightAttributedString: NSAttributedString {
    return R.string.localizable.circle_create_vc_add_button()
      .set(style: theme.nextButtonHighlightTextStyle)
  }

  var bannerButtonNormalAttributedString: NSAttributedString {
    return R.string.localizable.circle_create_vc_circle_name()
      .set(style: theme.bannerButtonNormalTextStyle)
  }

  var bannerButtonHighlightAttributedString: NSAttributedString {
    return R.string.localizable.circle_create_vc_circle_name_placeholder()
      .set(style: theme.bannerButtonHighlightTextStyle)
  }

  var avartTextAttributedString: NSAttributedString {
    return R.string.localizable.circle_create_vc_circle_category()
      .set(style: theme.avartTextStyle)
  }

  func nameAttributedString(_ name: String) -> NSAttributedString {
    return name.set(style: theme.nameTextStyle)
  }

  var textViewAttributedString: NSAttributedString {
    return R.string.localizable.circle_create_vc_circle_level()
      .set(style: theme.textViewStyle)
  }

  var ptextViewPlaceholderAttributedString: NSAttributedString {
    return R.string.localizable.circle_create_vc_circle_18y_limit()
      .set(style: theme.textViewPlaceholderStyle )
  }
  
}

extension CircleCreateProfileViewModel.Theme {


  var titleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 18)
      $0.maximumLineHeight = 27
      $0.minimumLineHeight = 27
      $0.color = UIColor.normalText
    }
  }

  var nextButtonNormalTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCMedium(size: 15)
      $0.maximumLineHeight = 22
      $0.minimumLineHeight = 22
      $0.color = UIColor.tappableText
    }
  }

  var nextButtonHighlightTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCMedium(size: 15)
      $0.maximumLineHeight = 22
      $0.minimumLineHeight = 22
      $0.color = UIColor.normalLightBg
    }
  }

  var bannerButtonNormalTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 13)
      $0.maximumLineHeight = 19
      $0.minimumLineHeight = 19
      $0.color = UIColor.hintTextGray
    }
  }

  var bannerButtonHighlightTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 12)
      $0.maximumLineHeight = 18
      $0.minimumLineHeight = 18
      $0.color = UIColor.normalLightBg
    }
  }

  var avartTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 11)
      $0.maximumLineHeight = 17
      $0.minimumLineHeight = 17
      $0.color = UIColor.hintTextGray
    }
  }

  var nameTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCMedium(size: 24)
      $0.maximumLineHeight = 36
      $0.minimumLineHeight = 36
      $0.color = UIColor.normalText
    }
  }

  var textViewPlaceholderStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 16)
      $0.maximumLineHeight = 24
      $0.minimumLineHeight = 24
      $0.color = UIColor.placeholderColor
    }
  }

  var textViewStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 16)
      $0.maximumLineHeight = 24
      $0.minimumLineHeight = 24
      $0.color = UIColor.normalText
    }
  }
}

