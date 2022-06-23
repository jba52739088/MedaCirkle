//
//  VerifyViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/22.
//

import UIKit
import SwiftRichString

class VerifyViewModel {

  struct Theme {
    let type: PageType
    init(pageType: PageType) {
      type = pageType
    }
  }

  var data: VerifyModel
  let theme: Theme
  init(data: VerifyModel, theme: Theme) {
    self.theme = theme
    self.data = data
  }

  var titleAttributedString: NSAttributedString {
    return theme.type.title
      .set(style: theme.titleTextStyle)
  }

  var subtitleAttributedString: NSAttributedString {
    return theme.type.subtitle
      .set(style: theme.subtitleTextStyle)
  }

  func infoAttributedString(info: String) -> NSAttributedString {
    return info
      .set(style: theme.infoTextStyle)
  }

  func hintAttributedString(info: String) -> NSAttributedString {
    return R.string.localizable.verify_vc_resend(info)
      .set(style: theme.hintTextStyle)
  }

  var hintReSendAttributedString: NSAttributedString {
    return R.string.localizable.verify_vc_resend_with_button()
      .set(style: theme.subtitleTextStyle)
  }

  var phonePlaceholderAttributedString: NSAttributedString {
    return R.string.localizable.verify_vc_phone_placeholder()
      .set(style: theme.textFieldPlaceholderTextStyle)
  }

  var nameAttributedString: NSAttributedString {
    return R.string.localizable.verify_vc_name()
      .set(style: theme.textFieldTitleTextStyle)
  }

  var genderAttributedString: NSAttributedString {
    return R.string.localizable.verify_vc_gender()
      .set(style: theme.textFieldTitleTextStyle)
  }

  var genderPlaceholderAttributedString: NSAttributedString {
    return R.string.localizable.verify_vc_gender_placeholder()
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

extension VerifyViewModel.Theme {

  enum PageType {
    case Mail
    case PhoneEntry
    case Phone
    case VerifySucceed

    var title: String {
      switch self{
      case .Mail:
        return R.string.localizable.verify_vc_mail_title()
      case .PhoneEntry, .Phone:
        return R.string.localizable.verify_vc_phone_title()
      case .VerifySucceed:
        return R.string.localizable.verify_vc_succeed_title()
      }
    }

    var subtitle: String {
      switch self{
      case .Mail, .Phone:
        return R.string.localizable.verify_vc_subtitle()
      case .PhoneEntry:
        return R.string.localizable.verify_vc_phone_subtitle()
      case .VerifySucceed:
        return R.string.localizable.verify_vc_succeed_subtitle()
      }
    }

    var isVerifySucceed: Bool {
      switch self {
      case .VerifySucceed:
        return true
      default:
        return false
      }
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

  var subtitleTextStyle: StyleProtocol {
    Style {
      $0.font = type.isVerifySucceed ? R.font.notoSansTCMedium(size: 22) : R.font.promptRegular(size: 16)
      $0.maximumLineHeight = type.isVerifySucceed ? 33 : 26
      $0.minimumLineHeight = type.isVerifySucceed ? 33 : 26
      $0.color = UIColor.black
    }
  }

  var infoTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.promptRegular(size: 16)
      $0.maximumLineHeight = 24
      $0.minimumLineHeight = 24
      $0.color = UIColor.black
    }
  }

  var hintTextStyle: StyleProtocol {
    let style = Style {
      $0.font = R.font.promptRegular(size: 16)
      $0.maximumLineHeight = 24
      $0.minimumLineHeight = 24
      $0.color = UIColor.black
      $0.alignment = .center
    }

    let boldStyle = Style {
      $0.font = R.font.promptMedium(size: 16)
      $0.color = UIColor.tappableText
    }

    let group = StyleGroup(base: style, ["b": boldStyle])
    return group
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

