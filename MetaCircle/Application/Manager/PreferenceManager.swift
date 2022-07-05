//
//  PreferenceManager.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/26.
//

import Foundation
import RxCocoa

//enum PreferenceDataSourceError: Error {
//  case invalidFormat(_ reason: String)
//}

protocol PreferenceDataSource {
  var welcomePageDone: Bool { get set }
  var lastUsername: String? { get set }
  var lastPassword: String? { get set }
}

class PreferenceManager {
  static let sharedInstance: PreferenceManager = PreferenceManager(dataSource: UserDefaultsStore.shared)
  private(set) var dataSource: PreferenceDataSource

  init(dataSource: PreferenceDataSource) {
    self.dataSource = dataSource
  }

  var welcomePageDone: Bool {
    get { return dataSource.welcomePageDone }
    set { dataSource.welcomePageDone = newValue }
  }

  var lastUsername: String? {
    get {
      return dataSource.lastUsername
    }
    set {
      dataSource.lastUsername = newValue
    }
  }

  var lastPassword: String? {
    get {
      return dataSource.lastPassword
    }
    set {
      dataSource.lastPassword = newValue
    }
  }
}
