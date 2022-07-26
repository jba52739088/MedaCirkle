//
//  EditWorkHistoryViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/27.
//

import UIKit
import SwiftRichString

class EditWorkHistoryViewModel {

  struct Theme {
    init() {
    }
  }

  let theme: Theme
  init(theme: Theme = Theme()) {
    self.theme = theme
  }

  var titleAttributedString: NSAttributedString {
    return R.string.localizable.profile_edit_work_history_title()
      .set(style: theme.titleTextStyle)
  }

  var hintAttributedString: NSAttributedString {
    return R.string.localizable.profile_edit_work_history_hint()
      .set(style: theme.hintTextStyle)
  }

  var postitonTitleAttributedString: NSAttributedString {
    return R.string.localizable.profile_edit_work_history_position_title()
      .set(style: theme.txtFieldTitleTextStyle)
  }

  var cpmpanyPlacehodlerAttributedString: NSAttributedString {
    return R.string.localizable.profile_edit_work_history_company_name()
      .set(style: theme.textFieldPlaceholderTextStyle)
  }

  var positionPlacehodlerAttributedString: NSAttributedString {
    return R.string.localizable.profile_edit_work_history_postiton()
      .set(style: theme.textFieldPlaceholderTextStyle)
  }

  var locationPlacehodlerAttributedString: NSAttributedString {
    return R.string.localizable.profile_edit_work_history_location()
      .set(style: theme.textFieldPlaceholderTextStyle)
  }

  var durationTitleAttributedString: NSAttributedString {
    return R.string.localizable.profile_edit_work_history_duration_title()
      .set(style: theme.txtFieldTitleTextStyle)
  }

  var datePlacehodlerAttributedString: NSAttributedString {
    return R.string.localizable.profile_edit_work_history_duration_placeholder()
      .set(style: theme.textFieldPlaceholderTextStyle)
  }

  var stillDoingAttributedString: NSAttributedString {
    return R.string.localizable.profile_edit_work_history_still_doing()
      .set(style: theme.txtFieldTitleTextStyle)
  }

  var statusTitleAttributedString: NSAttributedString {
    return R.string.localizable.profile_edit_education_status()
      .set(style: theme.txtFieldTitleTextStyle)
  }

  var introTitleAttributedString: NSAttributedString {
    return R.string.localizable.profile_edit_work_history_intro()
      .set(style: theme.txtFieldTitleTextStyle)
  }

  var introPlaceholderAttributedString: NSAttributedString {
    return R.string.localizable.profile_edit_work_history_intro_placeholder()
      .set(style: theme.textFieldPlaceholderTextStyle)
  }
}

extension EditWorkHistoryViewModel.Theme {


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




