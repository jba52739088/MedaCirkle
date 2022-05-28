//
//  ForgetPwdViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/26.
//

import UIKit
import SwiftRichString


class ForgetPwdViewModel {

  struct Theme {
    init() {
    }
  }

  let theme: Theme
  init() {
    self.theme = Theme()
  }

  var titleAttributedString: NSAttributedString {
    return R.string.localizable.forgetPwd_vc_title()
      .set(style: theme.titleTextStyle)
  }

  var subtitleAttributedString: NSAttributedString {
    return R.string.localizable.forgetPwd_vc_subtitle()
      .set(style: theme.subtitleTextStyle)
  }

  var phoneAttributedString: NSAttributedString {
    return R.string.localizable.forgetPwd_vc_phone_title()
      .set(style: theme.textFieldTitleTextStyle)
  }

  var phonePlaceholderAttributedString: NSAttributedString {
    return R.string.localizable.verify_vc_phone_placeholder()
      .set(style: theme.textFieldPlaceholderTextStyle)
  }

  var birthAttributedString: NSAttributedString {
    return R.string.localizable.verify_vc_birth()
      .set(style: theme.textFieldTitleTextStyle)
  }

  var birthPlaceholderAttributedString: NSAttributedString {
    return R.string.localizable.verify_vc_birth_placeholder()
      .set(style: theme.birthTextFieldPlaceholderTextStyle)
  }

}

extension ForgetPwdViewModel.Theme {


  var titleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCBold(size: 28)
      $0.maximumLineHeight = 41
      $0.minimumLineHeight = 41
      $0.color = UIColor.black
    }
  }

  var subtitleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.promptRegular(size: 16)
      $0.maximumLineHeight = 24
      $0.minimumLineHeight = 24
      $0.color = UIColor.black
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

  var birthTextFieldPlaceholderTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 17)
      $0.maximumLineHeight = 25
      $0.minimumLineHeight = 25
      $0.color = UIColor.placeholderColor
    }
  }

}

