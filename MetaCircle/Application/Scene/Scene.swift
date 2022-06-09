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
  case login
  case register
  case forgetPassword
  case resetPassword
  case verify(VerifyViewModel)
  case createCircle
  case circleCreateProfile
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
         (.login, .login),
         (.register, .register),
         (.forgetPassword, .forgetPassword),
         (.resetPassword, .resetPassword),
         (.createCircle, .createCircle),
         (.circleCreateProfile, .circleCreateProfile):
    return true
//    case let (.section(s1, _, _), .section(s2, _, _)):
//      return s1.isEqualTo(s2)
    case let (.chooseTopicFeature(vm1), .chooseTopicFeature(vm2)):
      return vm1.model.title == vm2.model.title
    case let (.verify(vm1), .verify(vm2)):
      return vm1.theme.type == vm2.theme.type
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
