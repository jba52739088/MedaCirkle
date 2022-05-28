//
//  UserDefaultsStore.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/26.
//

import Foundation

internal class UserDefaultsStore {
  private enum UserDefaultKey: String {
    case isFirstLaunch
  }

  static let shared = UserDefaultsStore(userDefaults: UserDefaults.standard)

  let userDefaults: UserDefaults

  /// Use a more correct name.
  /// Before the name is `isFirstLaunch`, but the actual meaning is if user passed welcome page.
  /// Even a user launched the app twice, he might not confirm the welcome page
  var welcomePageDone: Bool {
    get {
      return !userDefaults.bool(forKey: UserDefaultKey.isFirstLaunch.rawValue)
    }
    set(value) {
      userDefaults.set(!value, forKey: UserDefaultKey.isFirstLaunch.rawValue)
    }
  }


  init(userDefaults: UserDefaults) {
    self.userDefaults = userDefaults

    userDefaults.register(defaults: [
      UserDefaultKey.isFirstLaunch.rawValue: true
    ])
  }
}
