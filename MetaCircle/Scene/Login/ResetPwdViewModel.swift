//
//  ResetPwdViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/28.
//

import UIKit
import SwiftRichString


class ResetPwdViewModel {

  struct Theme {
    init() {
    }
  }

  let theme: Theme
  init() {
    self.theme = Theme()
  }

  var titleAttributedString: NSAttributedString {
    return R.string.localizable.resetPwd_vc_title()
      .set(style: theme.titleTextStyle)
  }

  var subtitleAttributedString: NSAttributedString {
    return R.string.localizable.resetPwd_vc_verify_succeed_hint()
      .set(style: theme.subtitleTextStyle)
  }

  var pwdAttributedString: NSAttributedString {
    return R.string.localizable.resetPwd_vc_pwd_title()
      .set(style: theme.textFieldTitleTextStyle)
  }

  var pwdPlaceholderAttributedString: NSAttributedString {
    return R.string.localizable.resetPwd_vc_password_placeholder()
      .set(style: theme.textFieldPlaceholderTextStyle)
  }

  var pwdHintAttributedString: NSAttributedString {
    return R.string.localizable.register_vc_password_hint()
      .set(style: theme.passwordHintTextStyle)
  }

  var rePwdPlaceholderAttributedString: NSAttributedString {
    return R.string.localizable.resetPwd_vc_re_password_placeholder()
      .set(style: theme.textFieldPlaceholderTextStyle)
  }

}

extension ResetPwdViewModel.Theme {


  var subtitleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCMedium(size: 22)
      $0.maximumLineHeight = 33
      $0.minimumLineHeight = 33
      $0.color = UIColor.black
    }
  }

  var titleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCBold(size: 28)
      $0.maximumLineHeight = 41
      $0.minimumLineHeight = 41
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

  var passwordHintTextStyle: StyleProtocol {
    let style = Style {
      $0.font = R.font.promptRegular(size: 14)
      $0.maximumLineHeight = 21
      $0.minimumLineHeight = 21
      $0.color = UIColor.hintTextGray
      $0.alignment = .left
    }

    let boldStyle = Style {
      $0.font = R.font.promptMedium(size: 14)
      $0.color = UIColor.tappableText
    }

    let group = StyleGroup(base: style, ["b": boldStyle])
    return group
  }
}


