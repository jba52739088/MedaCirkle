//
//  IntroViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/8.
//

import UIKit
import SwiftRichString


class IntroViewModel {
  struct Theme {}

  let theme = Theme()

  var registerAttributedString: NSAttributedString {
    return R.string.localizable.leading_ready_to_begin()
      .set(style: theme.readyToBeginTextStyle)
  }

  var skipAttributedString: NSAttributedString {
    return R.string.localizable.leading_skip()
      .set(style: theme.skipTextStyle)
  }

  func featureAttributedString(_ feature: String) -> NSAttributedString {
    return feature.set(style: theme.featureTextStyle)
  }

  var beginAttributedString: NSAttributedString {
    return R.string.localizable.leading_tutorial_begin()
      .set(style: theme.beginTextStyle)
  }
}

extension IntroViewModel.Theme {

  var readyToBeginTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCMedium(size: 20)
      $0.maximumLineHeight = 29
      $0.minimumLineHeight = 29
      $0.color = UIColor.tappableText
    }
  }

  var skipTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCMedium(size: 16)
      $0.maximumLineHeight = 24
      $0.minimumLineHeight = 24
      $0.color = UIColor.hintTextGray
    }
  }

  var featureTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCMedium(size: 25)
      $0.maximumLineHeight = 40
      $0.minimumLineHeight = 40
      $0.color = UIColor.normalText
    }
  }

  var beginTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCMedium(size: 17)
      $0.maximumLineHeight = 25
      $0.minimumLineHeight = 25
      $0.color = UIColor.tappableText
    }
  }
}
