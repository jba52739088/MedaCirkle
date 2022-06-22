//
//  KeychainStore.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/22.
//

import Foundation
import KeychainAccess

class KeychainStore {
//  static let shared = KeychainStore(keychain: Keychain(service: Globals.keychainServiceName))
  static let shared = KeychainStore(keychain: Keychain(service: Bundle.main.bundleIdentifier ?? "MetaCircle"))

  let keychain: Keychain

  init(keychain: Keychain) {
    self.keychain = keychain
  }
}

extension KeychainStore: UserSessionDataSource {
  var currentProfile: UserProfile? {
    get {
      nil
    }
    set {

    }
  }

  var currentProfileData: Data? {
    nil
  }

  var lastLoginUsername: String? {
    get {
      nil
    }
    set {

    }
  }

//  private static let prefix = "user_session"
//  private static let currentProfileKey = "\(prefix).current_profile"
//  private static let lastLoginUsernameKey = "\(prefix).last_login_username"
//
//  var currentProfile: UserProfile? {
//    get {
//      if let data = currentProfileData {
//        do {
//          return try JSONDecoder().decode(UserProfile.self, from: data)
//        } catch {
//          logger.error("Fail to decode current profile from keychain: \(error)")
//        }
//      }
//
//      return nil
//    }
//    set {
//      let key = KeychainStore.currentProfileKey
//      // Save profile as JSON data
//      if let newValue = newValue {
//        if let data = try? JSONEncoder().encode(newValue) {
//          do {
//            try keychain.comment("Current profile").set(data, key: key)
//          } catch {
//            logger.error("Fail to set current profile to keychain: \(error)")
//          }
//        }
//      } else {
//        do {
//          try keychain.remove(key)
//        } catch {
//          logger.error("Fail to remove current profile from keychain: \(error)")
//        }
//      }
//    }
//  }
//
//  var currentProfileData: Data? {
//    let key = KeychainStore.currentProfileKey
//    do {
//      return try keychain.getData(key)
//    } catch {
//      logger.error("Fail to retrieve current profile from keychain: \(error)")
//    }
//    return nil
//  }
//
//  var lastLoginUsername: String? {
//    get {
//      let key = KeychainStore.lastLoginUsernameKey
//      do {
//        return try keychain.getString(key)
//      } catch {
//        logger.error("Fail to retrieve last login username from keychain: \(error)")
//      }
//      return nil
//    }
//    set {
//      let key = KeychainStore.lastLoginUsernameKey
//      if let newValue = newValue {
//        do {
//          try keychain.comment("Last login username").set(newValue, key: key)
//        } catch {
//          logger.error("Fail to set last login username to keychain: \(error)")
//        }
//      } else {
//        do {
//          try keychain.remove(key)
//        } catch {
//          logger.error("Fail to remove last login username from keychain: \(error)")
//        }
//      }
//    }
//  }
}
