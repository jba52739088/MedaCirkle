//
//  CircleCreateViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/3.
//

import UIKit
import SwiftRichString

class CircleCreateViewModel {

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

  var addButtonNormalAttributedString: NSAttributedString {
    return R.string.localizable.circle_create_vc_add_button()
      .set(style: theme.addButtonTextStyle)
  }

  var addButtonDisableAttributedString: NSAttributedString {
    return R.string.localizable.circle_create_vc_add_button()
      .set(style: theme.addButtonDisableTextStyle)
  }

  var circleNameAttributedString: NSAttributedString {
    return R.string.localizable.circle_create_vc_circle_name()
      .set(style: theme.textFieldTitleTextStyle)
  }

  var circleNamePlaceholderAttributedString: NSAttributedString {
    return R.string.localizable.circle_create_vc_circle_name_placeholder()
      .set(style: theme.textFieldPlaceholderTextStyle)
  }

  var categoryAttributedString: NSAttributedString {
    return R.string.localizable.circle_create_vc_circle_category()
      .set(style: theme.textFieldTitleTextStyle)
  }

  var categoryPlaceholderAttributedString: NSAttributedString {
    return R.string.localizable.circle_create_vc_circle_category_placeholder()
      .set(style: theme.textFieldPlaceholderTextStyle)
  }

  var privacyAttributedString: NSAttributedString {
    return R.string.localizable.circle_create_vc_circle_privacy()
      .set(style: theme.textFieldTitleTextStyle)
  }

  func privacyOptionAttributedString(_ privacy: Privacy) -> NSAttributedString {
    return privacy.string.set(style: theme.privacyOptionsTitleTextStyle)
  }

  func privacyOptionDescriptionAttributedString(_ privacy: Privacy) -> NSAttributedString {
    return privacy.string.set(style: theme.privacyOptionsDescriptionTextStyle)
  }

  var privacyLevelAttributedString: NSAttributedString {
    return R.string.localizable.circle_create_vc_circle_level()
      .set(style: theme.textFieldTitleTextStyle)
  }

  var privacyLevelOptionAttributedString: NSAttributedString {
    return R.string.localizable.circle_create_vc_circle_18y_limit()
      .set(style: theme.privacyLevel18LimitTextStyle )
  }
}

extension CircleCreateViewModel {
  enum Privacy: CaseIterable {
    case Public
    case Optional
    case Private

    var string: String {
      switch self {
      case .Public:
        return R.string.localizable.circle_create_vc_circle_privacy_public()
      case .Optional:
        return R.string.localizable.circle_create_vc_circle_privacy_optional()
      case .Private:
        return R.string.localizable.circle_create_vc_circle_privacy_private()
      }
    }

    var description: String {
      switch self {
      case .Public:
        return R.string.localizable.circle_create_vc_circle_privacy_public_description()
      case .Optional:
        return R.string.localizable.circle_create_vc_circle_privacy_optional_description()
      case .Private:
        return R.string.localizable.circle_create_vc_circle_privacy_private_description()
      }
    }

    var image: UIImage? {
      switch self {
      case .Public:
        return R.image.icon_privacy_option_public()
      case .Optional:
        return R.image.icon_privacy_option_optional()
      case .Private:
        return R.image.icon_privacy_option_private()
      }
    }
  }
}

extension CircleCreateViewModel.Theme {


  var titleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 18)
      $0.maximumLineHeight = 27
      $0.minimumLineHeight = 27
      $0.color = UIColor.normalText
    }
  }

  var addButtonTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCMedium(size: 15)
      $0.maximumLineHeight = 22
      $0.minimumLineHeight = 22
      $0.color = UIColor.normalLightBg
    }
  }

  var addButtonDisableTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCMedium(size: 15)
      $0.maximumLineHeight = 22
      $0.minimumLineHeight = 22
      $0.color = UIColor.disableBtn
    }
  }

  var textFieldPlaceholderTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 17)
      $0.maximumLineHeight = 25
      $0.minimumLineHeight = 25
      $0.color = UIColor.placeholderColor
    }
  }

  var textFieldTitleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 15)
      $0.maximumLineHeight = 22
      $0.minimumLineHeight = 22
      $0.color = UIColor.textFieldTitle
    }
  }

  var privacyOptionsTitleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCMedium(size: 18)
      $0.maximumLineHeight = 27
      $0.minimumLineHeight = 27
      $0.color = UIColor.normalText
    }
  }

  var privacyOptionsDescriptionTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 16)
      $0.maximumLineHeight = 24
      $0.minimumLineHeight = 24
      $0.color = UIColor.categoryTextGray
    }
  }

  var privacyLevel18LimitTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 17)
      $0.maximumLineHeight = 25
      $0.minimumLineHeight = 25
      $0.color = UIColor.normalText
    }
  }

}

