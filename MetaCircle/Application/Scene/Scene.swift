//
//  Scene.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/25.
//

import Foundation

internal enum Scene {
  case leading
  case chooseTopic
  case chooseTopicFeature(TopicFeatureViewModel)
  case home
  case forgetPassword
  case resetPassword
  case createCircle
//  #if DEBUG
//  case debug
//  #endif
}

// MARK: - Equatable

extension Scene: Equatable {
  static func == (lhs: Scene, rhs: Scene) -> Bool {
    switch (lhs, rhs) {
    case (.leading, .leading),
         (.chooseTopic, .chooseTopic),
         (.home, .home),
         (.forgetPassword, .forgetPassword),
         (.resetPassword, .resetPassword),
         (.createCircle, .createCircle):
    return true
//    case let (.section(s1, _, _), .section(s2, _, _)):
//      return s1.isEqualTo(s2)
    case let (.chooseTopicFeature(vm1), .chooseTopicFeature(vm2)):
      return vm1.model.title == vm2.model.title
//    case let (.inAppBrowser(u1, _), .inAppBrowser(u2, _)):
//      return u1 == u2
//    #if DEBUG
//    case (.debug, .debug):
//      return true
//    #endif
    default:
      return false
    }
  }
}
