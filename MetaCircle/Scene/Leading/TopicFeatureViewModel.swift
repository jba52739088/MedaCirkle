//
//  TopicFeatureViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/8.
//

import UIKit
import SwiftRichString
import RxCocoa

class TopicFeatureViewModel {
  struct Theme {}

  let theme = Theme()
  var dataRelay = BehaviorRelay<[TempTopicFeature]>(value: [])
  var didSelectDataRelay = BehaviorRelay<[TempTopicFeature]>(value: [])

  let model: TempTopicModel

  init(model: TempTopicModel) {
    self.model = model
    createTempDatas()
  }

  var titleAttributedString: NSAttributedString {
    return model.title.set(style: theme.titleTextStyle)
  }

  var confirmAttributedString: NSAttributedString {
    return R.string.localizable.confirm()
      .set(style: theme.enableTextStyle)
  }

  var disableConfirmAttributedString: NSAttributedString {
    return R.string.localizable.confirm()
      .set(style: theme.disableTextStyle)
  }

  func addOrRemoveUnit(_ unit: TempTopicFeature) {
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

extension TopicFeatureViewModel {

  private func createTempDatas() {
    let datas: [TempTopicFeature] = [
      TempTopicFeature(title: "子類別1"),
      TempTopicFeature(title: "子類別2"),
      TempTopicFeature(title: "子類別3"),
      TempTopicFeature(title: "子類別4"),
      TempTopicFeature(title: "子類別5"),
      TempTopicFeature(title: "子類別6"),
      TempTopicFeature(title: "子類別7"),
      TempTopicFeature(title: "子類別8"),
      TempTopicFeature(title: "子類別9")
    ]
    dataRelay.accept(datas)
  }
}

extension TopicFeatureViewModel.Theme {

  var titleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCMedium(size: 19)
      $0.maximumLineHeight = 28
      $0.minimumLineHeight = 28
      $0.color = UIColor.normalText
    }
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
