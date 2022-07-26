//
//  EditSocialMediaViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/20.
//

import SwiftRichString
import RxSwift
import RxCocoa

enum SocialMedia: CaseIterable {
  case Facebook
  case Instagram
  case Youtube
  case Twitter
  case Github
  case LinkedIn

  var title: String {
    switch self {
    case .Facebook:
      return "Facebook"
    case .Instagram:
      return "Instagram"
    case .Youtube:
      return "Youtube"
    case .Twitter:
      return "Twitter"
    case .Github:
      return "Github"
    case .LinkedIn:
      return "LinkedIn"
    }
  }

  var icon: UIImage? {
    switch self {
    case .Facebook:
      return R.image.btn_social_media_facebook()
    case .Instagram:
      return R.image.btn_social_media_ig()
    case .Youtube:
      return R.image.btn_social_media_yt()
    case .Twitter:
      return R.image.btn_social_media_twwiter()
    case .Github:
      return R.image.btn_social_media_github()
    case .LinkedIn:
      return R.image.btn_social_media_linkedin()
    }
  }
}

class EditSocialMediaViewModel {

  struct Theme {
    init() {
    }
  }

  var itemsRelay = BehaviorRelay<[EditSocialMediaCellViewModel]>(value: [])
  var disposeBag = DisposeBag()


  deinit {
    disposeBag = DisposeBag()
  }

  let theme: Theme

  init(theme: Theme = Theme()) {
    self.theme = theme
    configItems()
  }

  private func configItems() {
    let items: [SocialMedia] = SocialMedia.allCases
    let vms = items.compactMap({ return EditSocialMediaCellViewModel(type: $0) })
    self.itemsRelay.accept(vms)
  }

  var titleAttributedString: NSAttributedString {
    return R.string.localizable.profile_edit_title()
      .set(style: theme.titleTextStyle)
  }
}

extension EditSocialMediaViewModel.Theme {


  var titleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 18)
      $0.maximumLineHeight = 27
      $0.minimumLineHeight = 27
      $0.color = UIColor.normalText
    }
  }
}

