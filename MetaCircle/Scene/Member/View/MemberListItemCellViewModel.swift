//
//  MemberIistItemCellViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/5.
//

import UIKit
import RxSwift
import SwiftRichString

class MemberListItemCellViewModel: MemberCellViewModel {

  struct Theme {
    init() {
    }
  }

  let theme: Theme
//  let disposeBag = DisposeBag()

  init(type: MemberListItem, theme: Theme = Theme()) {
    self.theme = theme
    super.init(type: type)
  }

  override func cellHeight() -> CGFloat {
    return type == .separator
    ? 40.f
    : type == .logout ? 34.f : 44.f
  }

  var titleAttributedString: NSAttributedString {
    return type.title.set(style: theme.titleTextStyle)
  }

}

extension MemberListItemCellViewModel.Theme {

  var titleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 18)
      $0.maximumLineHeight = 27
      $0.minimumLineHeight = 27
      $0.color = UIColor.normalText
    }
  }

}
