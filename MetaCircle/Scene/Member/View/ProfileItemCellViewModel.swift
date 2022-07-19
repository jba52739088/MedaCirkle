//
//  ProfileItemCellViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/12.
//

import UIKit
import RxSwift
import SwiftRichString

class ProfileItemCellViewModel: ProfileCellViewModel {

  struct Theme {
    init() {
    }
  }

  let theme: Theme

  init(type: ProfileListItem, theme: Theme = Theme()) {
    self.theme = theme
    super.init(type: type)
  }

  var icon: UIImage? {
    switch type {
    case .circle:
      return nil
    case .tag:
      return R.image.icon_edit()
    default:
      return R.image.btn_icon_pluse()
    }
  }

  var titleAttributedString: NSAttributedString {
    return type.title 
      .set(style: theme.titleTextStyle)
  }

  var bedgeAttributedString: NSAttributedString {
    return (type == .circle ? "0" : "")
      .set(style: theme.bedgeTextStyle)
  }

}

extension ProfileItemCellViewModel.Theme {

  var titleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.promptMedium(size: 20)
      $0.maximumLineHeight = 30
      $0.minimumLineHeight = 30
      $0.color = UIColor.normalText
    }
  }

  var bedgeTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.promptMedium(size: 20)
      $0.maximumLineHeight = 30
      $0.minimumLineHeight = 30
      $0.color = UIColor.textBlue
    }
  }

}
