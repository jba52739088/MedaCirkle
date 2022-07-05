//
//  UserDefaultsStore+Preference.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/26.
//

import Foundation

extension UserDefaultsStore: PreferenceDataSource {

  private static let lastUsernameKey = "lastUsername"
  private static let lastPassword = "lastPassword"

  var lastUsername: String? {
    get {
      return userDefaults.string(forKey: UserDefaultsStore.lastUsernameKey)
    }
    set {
      userDefaults.set(newValue, forKey: UserDefaultsStore.lastUsernameKey)
    }
  }

  var lastPassword: String? {
    get {
      return userDefaults.string(forKey: UserDefaultsStore.lastPassword)
    }
    set {
      userDefaults.set(newValue, forKey: UserDefaultsStore.lastPassword)
    }
  }

}
