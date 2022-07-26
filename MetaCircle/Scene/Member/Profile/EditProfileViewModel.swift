//
//  EditProfileViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/14.
//

import UIKit
import SwiftRichString

class EditProfileViewModel {

  struct Theme {
    init() {
    }
  }

  let theme: Theme
  init(theme: Theme = Theme()) {
    self.theme = theme
  }

  var titleAttributedString: NSAttributedString {
    return R.string.localizable.profile_edit_title()
      .set(style: theme.titleTextStyle)
  }

  var infoTitleAttributedString: NSAttributedString {
    return R.string.localizable.profile_edit_basic_info()
      .set(style: theme.sectionTitleTextStyle)
  }

  var nicknameTitleAttributedString: NSAttributedString {
    return R.string.localizable.profile_edit_nickname_title()
      .set(style: theme.txtFieldTitleTextStyle)
  }

  var nicknamePlacehodlerAttributedString: NSAttributedString {
    return R.string.localizable.profile_edit_nickname_placeHolder()
      .set(style: theme.textFieldPlaceholderTextStyle)
  }

  var nameTitleAttributedString: NSAttributedString {
    return R.string.localizable.profile_edit_name_title()
      .set(style: theme.txtFieldTitleTextStyle)
  }

  var namePlacehodlerAttributedString: NSAttributedString {
    return "姓名"
      .set(style: theme.textFieldPlaceholderTextStyle)
  }

  var genderTitleAttributedString: NSAttributedString {
    return R.string.localizable.verify_vc_gender()
      .set(style: theme.txtFieldTitleTextStyle)
  }

  var birthTitleAttributedString: NSAttributedString {
    return "生日"
      .set(style: theme.birthHintTextStyle)
  }

  var birthPlaceholderAttributedString: NSAttributedString {
    return R.string.localizable.verify_vc_birth_placeholder()
      .set(style: theme.textFieldPlaceholderTextStyle)
  }

  var birthHintAttributedString: NSAttributedString {
    return R.string.localizable.profile_edit_birth_hint()
      .set(style: theme.txtFieldTitleTextStyle)
  }

  var introTitleAttributedString: NSAttributedString {
    return R.string.localizable.profile_edit_intro_title()
      .set(style: theme.sectionTitleTextStyle)
  }
}

extension EditProfileViewModel.Theme {


  var titleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 18)
      $0.maximumLineHeight = 27
      $0.minimumLineHeight = 27
      $0.color = UIColor.normalText
    }
  }

  var sectionTitleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCMedium(size: 20)
      $0.maximumLineHeight = 29
      $0.minimumLineHeight = 29
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

  var birthHintTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.promptRegular(size: 15)
      $0.maximumLineHeight = 22
      $0.minimumLineHeight = 22
      $0.color = UIColor.textFieldTitle
    }
  }
}
