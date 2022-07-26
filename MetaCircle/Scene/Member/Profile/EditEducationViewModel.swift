//
//  EditEducationViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/21.
//

import UIKit
import SwiftRichString

class EditEducationViewModel {

  enum StudyStatus: CaseIterable {
    case graduated
    case noncompletion
    case studying

    var tag: Int {
      switch self {
      case .graduated:
        return 0
      case .noncompletion:
        return 1
      case .studying:
        return 2
      }
    }

    var title: String {
      switch self {
      case .graduated:
        return R.string.localizable.profile_website_edit_education_graduate()
      case .noncompletion:
        return R.string.localizable.profile_website_edit_education_quit()
      case .studying:
        return R.string.localizable.profile_website_edit_education_studying()
      }
    }

    var titleAttributedString: NSAttributedString {
      self.title.set(style: radioTextStyle)
    }

    var radioTextStyle: StyleProtocol {
      Style {
        $0.font = R.font.notoSansTCRegular(size: 17)
        $0.maximumLineHeight = 25
        $0.minimumLineHeight = 25
        $0.color = UIColor.normalText
      }
    }
  }

  struct Theme {
    init() {
    }
  }

  let theme: Theme
  init(theme: Theme = Theme()) {
    self.theme = theme
  }

  var titleAttributedString: NSAttributedString {
    return R.string.localizable.profile_website_edit_education_title()
      .set(style: theme.titleTextStyle)
  }

  var hintAttributedString: NSAttributedString {
    return R.string.localizable.profile_website_edit_education_hint()
      .set(style: theme.hintTextStyle)
  }

  var infoTitleAttributedString: NSAttributedString {
    return R.string.localizable.profile_website_edit_education_info_title()
      .set(style: theme.sectionTitleTextStyle)
  }

  var levelTitleAttributedString: NSAttributedString {
    return R.string.localizable.profile_website_edit_education_level()
      .set(style: theme.txtFieldTitleTextStyle)
  }

  var levelPlacehodlerAttributedString: NSAttributedString {
    return R.string.localizable.profile_website_edit_education_please_select()
      .set(style: theme.textFieldPlaceholderTextStyle)
  }

  var namePlacehodlerAttributedString: NSAttributedString {
    return R.string.localizable.profile_website_edit_education_school_name()
      .set(style: theme.textFieldPlaceholderTextStyle)
  }

  var dateTitleAttributedString: NSAttributedString {
    return R.string.localizable.profile_website_edit_education_date()
      .set(style: theme.txtFieldTitleTextStyle)
  }

  var dateStartAttributedString: NSAttributedString {
    return R.string.localizable.profile_website_edit_education_start()
      .set(style: theme.textFieldPlaceholderTextStyle)
  }

  var dateEndAttributedString: NSAttributedString {
    return R.string.localizable.profile_website_edit_education_end()
      .set(style: theme.textFieldPlaceholderTextStyle)
  }

  var statusTitleAttributedString: NSAttributedString {
    return R.string.localizable.profile_website_edit_education_status()
      .set(style: theme.txtFieldTitleTextStyle)
  }

  var majorTitleAttributedString: NSAttributedString {
    return R.string.localizable.profile_website_edit_education_major()
      .set(style: theme.sectionTitleTextStyle)
  }

  var majorPlaceholderAttributedString: NSAttributedString {
    return R.string.localizable.profile_website_edit_education_department_name()
      .set(style: theme.textFieldPlaceholderTextStyle)
  }

  var introTitleAttributedString: NSAttributedString {
    return R.string.localizable.profile_website_edit_education_intro_title()
      .set(style: theme.sectionTitleTextStyle)
  }
}

extension EditEducationViewModel.Theme {


  var titleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.promptRegular(size: 18)
      $0.maximumLineHeight = 28
      $0.minimumLineHeight = 28
      $0.color = UIColor.normalText
    }
  }

  var hintTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 16)
      $0.maximumLineHeight = 24
      $0.minimumLineHeight = 24
      $0.color = UIColor.hintTextGray2
    }
  }

  var sectionTitleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCMedium(size: 16)
      $0.maximumLineHeight = 24
      $0.minimumLineHeight = 24
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
      $0.maximumLineHeight = 25
      $0.minimumLineHeight = 25
      $0.color = UIColor.placeholderColor
    }
  }


}



