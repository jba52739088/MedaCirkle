//
//  MemberCellViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/6.
//

import UIKit

let tempProfile = Profile(banner: "", avatar: "", nickname: "Lionel Taurus", name: "陳向依", hideName: false, gender: 1, hideGender: false, birthday: "", hideBirthday: false)

enum MemberListItem {
  case profile
  case info
  case bookmark
  case tag
  case bigcircle
  case draft
  case wallet
  case gift
  case volume
  case history
  case account
  case help
  case setting
  case logout
  case separator

  var title: String {
    switch self {
    case .bookmark:
      return R.string.localizable.member_list_item_bookmark()
    case .tag:
      return R.string.localizable.member_list_item_tag()
    case .bigcircle:
      return R.string.localizable.member_list_item_bigcircle()
    case .draft:
      return R.string.localizable.member_list_item_draft()
    case .wallet:
      return R.string.localizable.member_list_item_wallet()
    case .gift:
      return R.string.localizable.member_list_item_gift()
    case .volume:
      return R.string.localizable.member_list_item_volume()
    case .history:
      return R.string.localizable.member_list_item_history()
    case .account:
      return R.string.localizable.member_list_item_account()
    case .help:
      return R.string.localizable.member_list_item_help()
    case .setting:
      return R.string.localizable.member_list_item_setting()
    case .logout:
      return R.string.localizable.member_list_item_logout()
    default:
      return ""
    }
  }

  var icon: UIImage? {
    switch self {
    case .bookmark:
      return R.image.icon_member_3_bookmark()
    case .tag:
      return R.image.icon_member_7_tag()
    case .bigcircle:
      return R.image.icon_member_1_bigcircle()
    case .draft:
      return R.image.icon_member_5_draft()
    case .wallet:
      return R.image.icon_member_wallet()
    case .gift:
      return R.image.icon_gift_line_26()
    case .volume:
      return R.image.icon_member_4_circle_volume()
    case .history:
      return R.image.icon_member_6_history()
    case .account:
      return R.image.icon_member_9_account()
    case .help:
      return R.image.icon_member_11_help()
    case .setting:
      return R.image.icon_member_12_setting()
    default:
      return nil
    }
  }

  var viewModel: MemberCellViewModel {
    switch self {
    case .profile:
      return MemberProfileCellViewModel(profile: tempProfile)
    case .info:
      return MemberInfoCellViewModel()
    default:
      return MemberListItemCellViewModel(type: self)
    }

  }

  static func == (lhs: MemberListItem, rhs: MemberListItem) -> Bool {
    switch (lhs, rhs) {
    case (.profile, .profile),
         (.info, .info),
         (.bookmark, .bookmark),
         (.tag, .tag),
         (.bigcircle, .bigcircle),
         (.draft, .draft),
         (.wallet, .wallet),
         (.gift, .gift),
         (.volume, .volume),
         (.history, .history),
         (.account, .account),
         (.help, .help),
         (.setting, .setting),
         (.logout, .logout),
         (.separator, .separator):
      return true
    default:
      return false
    }
  }
}


class MemberCellViewModel: TableViewCellViewModel {

  let type: MemberListItem

  init(type: MemberListItem) {
    self.type = type
  }

  func cellHeight() -> CGFloat {
    return type == .separator ? 40.f : 44.f
  }

}
