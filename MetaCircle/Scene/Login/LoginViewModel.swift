//
//  LoginViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/18.
//

import UIKit
import SwiftRichString
import RxSwift

class LoginViewModel {
  struct Theme {}

  let theme = Theme()
  var disposeBag = DisposeBag()

  deinit {
    disposeBag = DisposeBag()
  }

  var registerAttributedString: NSAttributedString {
    return R.string.localizable.login_vc_register_label()
      .set(style: theme.registerTextStyle)
  }

  var titleAttributedString: NSAttributedString {
    return R.string.localizable.login_vc_title()
      .set(style: theme.titleTextStyle)
  }

  var subtitleAttributedString: NSAttributedString {
    return R.string.localizable.login_vc_subtitle()
      .set(style: theme.subtitleTextStyle)
  }

  var facebookAttributedString: NSAttributedString {
    return R.string.localizable.login_vc_login_by_facebook()
      .set(style: theme.mediaLoginTextStyle(textColor: .white))
  }

  var twitterAttributedString: NSAttributedString {
    return R.string.localizable.login_vc_login_by_twitter()
      .set(style: theme.mediaLoginTextStyle(textColor: .white))
  }

  var googleAttributedString: NSAttributedString {
    return R.string.localizable.login_vc_login_by_google()
      .set(style: theme.mediaLoginTextStyle(textColor: .black))
  }

  var midAttributedString: NSAttributedString {
    return R.string.localizable.login_vc_login_mid_label()
      .set(style: theme.midLoginTextStyle)
  }

  var emailAttributedString: NSAttributedString {
    return R.string.localizable.login_vc_login_mail_title()
      .set(style: theme.textFieldTitleTextStyle)
  }

  var emailPlaceholderAttributedString: NSAttributedString {
    return R.string.localizable.login_vc_login_mail_placeholder()
      .set(style: theme.textFieldPlaceholderTextStyle)
  }

  var passwordAttributedString: NSAttributedString {
    return R.string.localizable.login_vc_login_password_title()
      .set(style: theme.textFieldTitleTextStyle)
  }

  var passwordPlaceholderAttributedString: NSAttributedString {
    return R.string.localizable.login_vc_login_password_placeholder()
      .set(style: theme.textFieldPlaceholderTextStyle)
  }

  var forgetPwdAttributedString: NSAttributedString {
    return R.string.localizable.login_vc_login_password_forgot()
      .set(style: theme.forgetTextStyle)
  }

  var enableLoginAttributedString: NSAttributedString {
    return R.string.localizable.login_vc_login_button()
      .set(style: theme.enableLoginTextStyle)
  }

  var disableLoginAttributedString: NSAttributedString {
    return R.string.localizable.login_vc_login_button()
      .set(style: theme.disableLoginTextStyle)
  }

  func errorAttributedString(error string: String) -> NSAttributedString {
    return string.set(style: theme.errorTextStyle)
  }

  func doLogin(mail: String, password: String) {

  }

}

extension LoginViewModel.Theme {

  var registerTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 16)
      $0.maximumLineHeight = 24
      $0.minimumLineHeight = 24
      $0.color = UIColor.black
    }
  }

  var titleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 24)
      $0.maximumLineHeight = 36
      $0.minimumLineHeight = 24
      $0.color = UIColor.black
    }
  }

  var subtitleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCBold(size: 28)
      $0.maximumLineHeight = 41
      $0.minimumLineHeight = 28
      $0.color = UIColor.black
    }
  }

  func mediaLoginTextStyle(textColor: UIColor) -> StyleProtocol {
    Style {
      $0.font = R.font.promptMedium(size: 17)
      $0.maximumLineHeight = 26
      $0.minimumLineHeight = 26
      $0.color = textColor
    }
  }

  var midLoginTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 18)
      $0.maximumLineHeight = 27
      $0.minimumLineHeight = 27
      $0.color = "#5A5C5F".color
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

  var textFieldPlaceholderTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 17)
      $0.maximumLineHeight = 25
      $0.minimumLineHeight = 25
      $0.color = UIColor.placeholderColor
    }
  }

  var textFieldErrorTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 14)
      $0.maximumLineHeight = 20
      $0.minimumLineHeight = 20
      $0.color = UIColor.textFieldError
    }
  }

  var forgetTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCMedium(size: 16)
      $0.maximumLineHeight = 24
      $0.minimumLineHeight = 24
      $0.color = UIColor.tappableText
    }
  }

  var errorTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 14)
      $0.maximumLineHeight = 20
      $0.minimumLineHeight = 20
      $0.color = UIColor.textFieldError
    }
  }

  var enableLoginTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 17)
      $0.maximumLineHeight = 25
      $0.minimumLineHeight = 25
      $0.color = UIColor.white
    }
  }

  var disableLoginTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 17)
      $0.maximumLineHeight = 25
      $0.minimumLineHeight = 25
      $0.color = UIColor.placeholderColor
    }
  }
}
