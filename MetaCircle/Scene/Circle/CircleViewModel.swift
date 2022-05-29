//
//  CircleViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/29.
//

import UIKit
import SwiftRichString


class CircleViewModel {

  struct Theme {
    init() {
    }
  }

  let theme: Theme
  init(theme: Theme = Theme()) {
    self.theme = theme
  }

  var titleAttributedString: NSAttributedString {
    return R.string.localizable.circle_vc_title()
      .set(style: theme.titleTextStyle)
  }

  var addButtonAttributedString: NSAttributedString {
    return R.string.localizable.circle_vc_add_button()
      .set(style: theme.addButtonTextStyle)
  }

  var joinedButtonNormalAttributedString: NSAttributedString {
    return R.string.localizable.circle_vc_joined()
      .set(style: theme.categoryButtonNormalStyle)
  }

  var joinedButtonSelectedAttributedString: NSAttributedString {
    return R.string.localizable.circle_vc_joined()
      .set(style: theme.categoryButtonSelectedStyle)
  }

  var createdButtonNormalAttributedString: NSAttributedString {
    return R.string.localizable.circle_vc_created()
      .set(style: theme.categoryButtonNormalStyle)
  }

  var createdButtonSelectedAttributedString: NSAttributedString {
    return R.string.localizable.circle_vc_created()
      .set(style: theme.categoryButtonSelectedStyle)
  }

}

extension CircleViewModel.Theme {


  var titleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCBold(size: 28)
      $0.maximumLineHeight = 41
      $0.minimumLineHeight = 41
      $0.color = UIColor.normalText
    }
  }

  var addButtonTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCMedium(size: 16)
      $0.maximumLineHeight = 24
      $0.minimumLineHeight = 24
      $0.color = UIColor.normalLightBg
    }
  }

  var categoryButtonNormalStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 18)
      $0.maximumLineHeight = 27
      $0.minimumLineHeight = 27
      $0.color = UIColor.categoryTextGray
    }
  }

  var categoryButtonSelectedStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCMedium(size: 18)
      $0.maximumLineHeight = 27
      $0.minimumLineHeight = 27
      $0.color = UIColor.normalText
    }
  }

}

