//
//  ProfileHeaderCellViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/12.
//

import UIKit
import RxSwift
import SwiftRichString

class ProfileHeaderCellViewModel: ProfileCellViewModel {

  struct Theme {
    init() {
    }
  }

  let theme: Theme
//  let disposeBag = DisposeBag()

  init(theme: Theme = Theme()) {
    self.theme = theme
    super.init(type: .header)
  }

  var avatar: UIImage? {
    R.image.img_avatar_5()
  }

  var editBannerAttributedString: NSAttributedString {
    return R.string.localizable.profile_edit_banner()
      .set(style: theme.editBannerTextStyle)
  }

  var nickNameAttributedString: NSAttributedString {
    return "Lionel Taurus"
      .set(style: theme.nickNameTextStyle)
  }

  var nameAttributedString: NSAttributedString {
    return "陳向依"
      .set(style: theme.nameTextStyle)
  }

  var genderIcon: UIImage? {
    R.image.icon_gender_female()
  }

  var genderAttributedString: NSAttributedString {
    return "女"
      .set(style: theme.genderTextStyle)
  }

  var birthIcon: UIImage? {
    R.image.icon_birthday()
  }

  var birthAttributedString: NSAttributedString {
    return "1994/12/5"
      .set(style: theme.genderTextStyle)
  }

  var infoAttributedString: NSAttributedString {
    return infoString
      .set(style: infoString == R.string.localizable.profile_intro() ? theme.unEditInfoTextStyle : theme.editedInfoTextStyle)
  }

  var infoString: String {
    return R.string.localizable.profile_intro()
//    return "安安的餐桌日常，且深怕被AI人工智慧取代的產品設計師!!過文字一起成為更好的產品設計師理性>感性，規劃甚至是家。"
  }

  override func cellHeight() -> CGFloat {
    let screenWidth = UIScreen.main.bounds.width
    return 350 + infoAttributedString.height(withConstrainedWidth: screenWidth)
  }

}

extension ProfileHeaderCellViewModel.Theme {

  var editBannerTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 12)
      $0.maximumLineHeight = 18
      $0.minimumLineHeight = 18
      $0.color = UIColor.white
    }
  }

  var nickNameTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.promptSemiBold(size: 22)
      $0.maximumLineHeight = 33
      $0.minimumLineHeight = 33
      $0.color = UIColor.normalText
    }
  }

  var nameTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 18)
      $0.maximumLineHeight = 27
      $0.minimumLineHeight = 27
      $0.color = UIColor.normalText
    }
  }

  var genderTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 16)
      $0.maximumLineHeight = 24
      $0.minimumLineHeight = 24
      $0.color = UIColor.normalText
    }
  }

  var birthTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.promptRegular(size: 16)
      $0.maximumLineHeight = 24
      $0.minimumLineHeight = 24
      $0.color = UIColor.normalText
    }
  }

  var unEditInfoTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.promptSemiBold(size: 22)
      $0.maximumLineHeight = 33
      $0.minimumLineHeight = 33
      $0.color = UIColor.normalText
    }
  }

  var editedInfoTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 15)
      $0.maximumLineHeight = 25
      $0.minimumLineHeight = 25
      $0.color = UIColor.normalText
    }
  }
}

