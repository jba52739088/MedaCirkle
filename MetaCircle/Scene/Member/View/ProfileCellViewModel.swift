//
//  ProfileCellViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/12.
//

import UIKit

enum ProfileListItem: CaseIterable {
  case header
  case website
  case socialMedia
  case circle
  case tag
  case education
  case workHistory
  case skills
  case careerBreak

  var title: String {
    switch self {
    case .website:
      return R.string.localizable.profile_list_item_website()
    case .socialMedia:
      return R.string.localizable.profile_list_item_socialMedia()
    case .circle:
      return R.string.localizable.profile_list_item_circle()
    case .tag:
      return R.string.localizable.profile_list_item_tag()
    case .education:
      return R.string.localizable.profile_list_item_education()
    case .workHistory:
      return R.string.localizable.profile_list_item_workHistory()
    case .skills:
      return R.string.localizable.profile_list_item_skills()
    case .careerBreak:
      return R.string.localizable.profile_list_item_careerBreak()
    default:
      return ""
    }
  }

  var viewModel: ProfileCellViewModel {
    switch self {
    case .header:
      return ProfileHeaderCellViewModel()
    default:
      return ProfileItemCellViewModel(type: self)
    }
  }

  var scene: Scene {
    switch self {
    case .header:
      return .editProfile
    case .website:
      return .editWebsite
    case .socialMedia:
      return .editSocialMedia
    case .education:
      return .editEducation
    case .workHistory:
      return .editWorkHistory
    default:
      return .editProfile
    }
  }
}


class ProfileCellViewModel: TableViewCellViewModel {

  let type: ProfileListItem

  init(type: ProfileListItem) {
    self.type = type
  }

  func cellHeight() -> CGFloat {
    return type != .header ? 80.f : 420.f
  }

}
