//
//  TopicViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/8.
//

import UIKit
import SwiftRichString
import RxCocoa

class TopicViewModel {
  struct Theme {}

  let theme = Theme()
  var dataRelay = BehaviorRelay<[TempTopicModel]>(value: [])
  var didSelectDataRelay = BehaviorRelay<[TempTopicModel]>(value: [])

  init() {
    createTempDatas()
  }

  var titleAttributedString: NSAttributedString {
    return R.string.localizable.topic_options_title()
      .set(style: theme.titleTextStyle)
  }

  var subtitleAttributedString: NSAttributedString {
    return R.string.localizable.topic_options_subtitle()
      .set(style: theme.subtitleTextStyle)
  }

  var countHintAttributedString: NSAttributedString {
    return R.string.localizable.topic_options_count_label()
      .set(style: theme.countHintTextStyle)
  }

  func didSelectAttributedString(_ count: Int) -> NSAttributedString {
    return R.string.localizable.topic_options_selected_count("\(count)").set(style: theme.didSelectTextStyle)
  }


  var nextAttributedString: NSAttributedString {
    return R.string.localizable.topic_options_next()
      .set(style: theme.enableTextStyle)
  }

  var disableNextAttributedString: NSAttributedString {
    return R.string.localizable.topic_options_next()
      .set(style: theme.disableTextStyle)
  }

  var confirmAttributedString: NSAttributedString {
    return R.string.localizable.confirm()
      .set(style: theme.enableTextStyle)
  }

  var disableConfirmAttributedString: NSAttributedString {
    return R.string.localizable.confirm()
      .set(style: theme.disableTextStyle)
  }

  func addOrRemoveUnit(_ unit: TempTopicModel) {
    assert(Thread.current.isMainThread, "should call removeUnit() in main thread")
    var didSelectData = didSelectDataRelay.value
    if let index = didSelectData.firstIndex(where: { $0.title == unit.title }) {
      didSelectData.remove(at: index)
    } else {
      didSelectData.append(unit)
    }
    didSelectDataRelay.accept(didSelectData)
  }

}

extension TopicViewModel {

  private func createTempDatas() {
    let datas: [TempTopicModel] = [
      TempTopicModel(image: R.image.icon_Interest_camer(), title: "類別名稱1", subType: []),
      TempTopicModel(image: R.image.icon_Interest_camer(), title: "類別名稱2", subType: []),
      TempTopicModel(image: R.image.icon_Interest_camer(), title: "類別名稱3", subType: []),
      TempTopicModel(image: R.image.icon_Interest_camer(), title: "類別名稱4", subType: []),
      TempTopicModel(image: R.image.icon_Interest_camer(), title: "類別名稱5", subType: []),
      TempTopicModel(image: R.image.icon_Interest_camer(), title: "類別名稱6", subType: []),
      TempTopicModel(image: R.image.icon_Interest_camer(), title: "類別名稱7", subType: []),
      TempTopicModel(image: R.image.icon_Interest_camer(), title: "類別名稱8", subType: []),
      TempTopicModel(image: R.image.icon_Interest_camer(), title: "類別名稱9", subType: []),
      TempTopicModel(image: R.image.icon_Interest_camer(), title: "類別名稱10", subType: []),
      TempTopicModel(image: R.image.icon_Interest_camer(), title: "類別名稱11", subType: []),
      TempTopicModel(image: R.image.icon_Interest_camer(), title: "類別名稱12", subType: []),
      TempTopicModel(image: R.image.icon_Interest_camer(), title: "類別名稱13", subType: []),
      TempTopicModel(image: R.image.icon_Interest_camer(), title: "類別名稱14", subType: []),
      TempTopicModel(image: R.image.icon_Interest_camer(), title: "類別名稱15", subType: [])
    ]
    dataRelay.accept(datas)
  }
}

extension TopicViewModel.Theme {

  var titleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCBold(size: 28)
      $0.maximumLineHeight = 41
      $0.minimumLineHeight = 41
      $0.color = UIColor.normalText
    }
  }

  var subtitleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 18)
      $0.maximumLineHeight = 27
      $0.minimumLineHeight = 27
      $0.color = UIColor.normalText
    }
  }

  var countHintTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 16)
      $0.maximumLineHeight = 24
      $0.minimumLineHeight = 24
      $0.color = UIColor.normalText
    }
  }

  var didSelectTextStyle: StyleProtocol {
    let style = Style {
      $0.font = R.font.notoSansTCMedium(size: 16)
      $0.maximumLineHeight = 24
      $0.minimumLineHeight = 24
      $0.color = UIColor.normalText
      $0.alignment = .left
    }

    let boldStyle = Style {
      $0.font = R.font.promptMedium(size: 16)
      $0.color = UIColor.textBlue
    }

    let group = StyleGroup(base: style, ["b": boldStyle])
    return group
  }

  var enableTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCMedium(size: 17)
      $0.maximumLineHeight = 25
      $0.minimumLineHeight = 25
      $0.color = UIColor.white
    }
  }

  var disableTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCMedium(size: 17)
      $0.maximumLineHeight = 25
      $0.minimumLineHeight = 25
      $0.color = UIColor.placeholderColor
    }
  }
}
