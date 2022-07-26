//
//  EditWebSiteViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/20.
//

import UIKit
import SwiftRichString

class EditWebSiteViewModel {

  struct Theme {
    init() {
    }
  }

  let theme: Theme
  init(theme: Theme = Theme()) {
    self.theme = theme
  }

  var titleAttributedString: NSAttributedString {
    return R.string.localizable.profile_website_edit_title()
      .set(style: theme.titleTextStyle)
  }

  var webTitleAttributedString: NSAttributedString {
    return R.string.localizable.profile_website_edit_web_title()
      .set(style: theme.txtFieldTitleTextStyle)
  }

  var webPlacehodlerAttributedString: NSAttributedString {
    return R.string.localizable.profile_website_edit_web_placeholder()
      .set(style: theme.textFieldPlaceholderTextStyle)
  }

  var urlTitleAttributedString: NSAttributedString {
    return R.string.localizable.profile_website_edit_web_url_title()
      .set(style: theme.txtFieldTitleTextStyle)
  }

  var urlPlacehodlerAttributedString: NSAttributedString {
    return R.string.localizable.profile_website_edit_web_url_placeholder()
      .set(style: theme.textFieldPlaceholderTextStyle)
  }
}

extension EditWebSiteViewModel.Theme {

  var titleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 18)
      $0.maximumLineHeight = 27
      $0.minimumLineHeight = 27
      $0.color = UIColor.normalText
    }
  }

  var txtFieldTitleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCMedium(size: 15)
      $0.maximumLineHeight = 22
      $0.minimumLineHeight = 22
      $0.color = UIColor.textFieldTitle
    }
  }

  var textFieldPlaceholderTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 17)
      $0.maximumLineHeight = 26
      $0.minimumLineHeight = 26
      $0.color = UIColor.placeholderColor
    }
  }
}

