//
//  UserSessionManager.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/22.
//

import Foundation
import RxCocoa
import RxSwift

public protocol UserSessionDataSource {
  // Profile for current user session
  var currentProfile: UserProfile? { get set }
  // Profile for current user session, in the format of data
  var currentProfileData: Data? { get }
  // Username for the last logged in user
  var lastLoginUsername: String? { get set }
}

public class UserSessionManager {
//  var isSignIned: Bool {
//    currentProfile != nil
//  }

//  enum CookieName {
//    static let drupalVisitorId = "Drupal.visitor.uid"
//    static let drupalVisitorUsername = "Drupal.visitor.username"
//    static let drupalVisitorEmail = "Drupal.visitor.mail"
//    static let drupalVisitorESIName = "Drupal.visitor.esiname"
//    static let inAppSubscriptionStaus = "ua_a"
//  }

//  // Notification info sent when the current profile is set
//  struct CurrentProfileDidSet: Notificationable {
//    static let notificationName = Notification.Name(rawValue: "UserSessionManager.currentProfileDidSet")
//
//    var profile: UserProfile?
//  }
//
//  // Notification info sent when the last login username is set
//  struct LastLoginUsernameDidSet: Notificationable {
//    static let notificationName = Notification.Name(rawValue: "UserSessionManager.lastLoginUsernameDidSet")
//
//    var lastLoginUsername: String?
//  }
//
//  struct SessionDidUpdate: Notificationable {
//    static let notificationName = Notification.Name(rawValue: "UserSessionManager.sessionDidUpdate")
//    let session: UserSession
//  }

  private let cookieStore = HTTPCookieStorage.shared
  private var dataSource: UserSessionDataSource

  init(dataSource: UserSessionDataSource) {
    self.dataSource = dataSource
  }

//  func requestSignIn(source: SignInFlowSource, completion: ((Bool) -> Void)? = nil) {
//    var userInfo: [AnyHashable: Any] = [
//      Notification.UserInfoKey.signInFlowSource.rawValue: source
//    ]
//    if let completion = completion {
//      userInfo[Notification.UserInfoKey.action.rawValue] = completion
//    }
//
//    NotificationCenter.default.post(name: .RequestUserSignIn, object: nil, userInfo: userInfo)
//  }
//
//  func updateSessionIfNeeded(session: UserSession) {
//    guard let profile = currentProfile, !profile.session.isEqual(to: session) else { return }
//    currentProfile?.session = session
//
//    let notificationable = SessionDidUpdate(session: session)
//    NotificationCenter.default.post(notificationable, object: nil)
//  }
}

// MARK: - Helper

extension UserSessionManager {
  static let shared = UserSessionManager(dataSource: KeychainStore.shared)
//
//  var currentProfile: UserProfile? {
//    get {
//      return dataSource.currentProfile
//    }
//    set {
//      dataSource.currentProfile = newValue
//
//      // Clear web view cookies
//      if newValue == nil {
//        clearWebViewCookies()
//      }
//
//      // Send notification
//      let notificationable = CurrentProfileDidSet(profile: newValue)
//      NotificationCenter.default.post(notificationable, object: nil)
//    }
//  }
//
//  var lastLoginUsername: String? {
//    get {
//      return dataSource.lastLoginUsername
//    }
//    set {
//      dataSource.lastLoginUsername = newValue
//
//      // Send notification
//      let notificationable = LastLoginUsernameDidSet(lastLoginUsername: newValue)
//      NotificationCenter.default.post(notificationable, object: nil)
//    }
//  }
}

//// MARK: - Cookies
//
//extension UserSessionManager {
//  enum CookieKind {
//    case csrf
//    case session
//    case drupalUserId
//  }
//
//  func clearWebViewCookies() {
//    let domain = EnvironmentManager.current.configuration.webviewCommentDomain
//    DispatchQueue.main.async {
//      let dataStore = WKWebsiteDataStore.default()
//      dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
//        dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), for: records.filter { $0.displayName.contains(domain) }) {
//          logger.debug("[Cookies] Deleted \(domain) Type: \(WKWebsiteDataStore.allWebsiteDataTypes())")
//        }
//      }
//    }
//  }
//
//  static func createCookieForSCMPDomain(properties: [HTTPCookiePropertyKey: Any]) -> HTTPCookie? {
//    let cookieDomain = EnvironmentManager.current.configuration.webviewCommentDomain
//    let baseProperties: [HTTPCookiePropertyKey: Any] = [
//      .domain: "." + cookieDomain, // For this domain and its sub-domain
//      .path: "/",
//      .expires: Date(timeIntervalSinceNow: 2592000) // 30 Days
//    ]
//    return HTTPCookie(properties: baseProperties.merging(properties, uniquingKeysWith: { _, new in new }))
//  }
//
//  /// Return all the session cookies needed for certain profile
//  static func createSessionCookies(for profile: UserProfile) -> [HTTPCookie] {
//    var cookieProperties: [[HTTPCookiePropertyKey: Any]] = [
//      // Drupal user id
//      [
//        .name: CookieName.drupalVisitorId,
//        .value: profile.id
//      ],
//      // Drupal user name
//      [
//        .name: CookieName.drupalVisitorUsername,
//        .value: profile.name ?? ""
//      ],
//      // Drupal user ESI name
//      [
//        .name: CookieName.drupalVisitorESIName,
//        .value: profile.name ?? ""
//      ]
//    ] + profile.session.accept(visitor: AccountSessionCookieProperties())
//
//    // Drupal user email
//    if let email = profile.email {
//      cookieProperties.append([
//        .name: CookieName.drupalVisitorEmail,
//        .value: email
//      ])
//    }
//
//    return cookieProperties.compactMap({ UserSessionManager.createCookieForSCMPDomain(properties: $0) })
//  }
//
//  static func createIapCookie() -> HTTPCookie? {
//    let cookieProperties: [HTTPCookiePropertyKey: Any] = [
//      .name: CookieName.inAppSubscriptionStaus,
//      .value: Date().millisecondsString
//    ]
//    return createCookieForSCMPDomain(properties: cookieProperties)
//  }
//}
//
//// MARK: - Profile Migration
//
//extension UserSessionManager {
//  func migrateProfileIfNeeded() {
//    guard let data = dataSource.currentProfileData else { return }
//
//    let mirgrator = UserModelMirgrator()
//    if let profile = mirgrator.convert(data: data) {
//      dataSource.currentProfile = profile
//    }
//  }
//}
//
//// MARK: AccountSession visitor for cookies
//
//private let kTokenSessionAccessTokenCookieName: String = "scmp_at"
//private let kTokenSessionRefreshTokenCookieName: String = "scmp_rt"
//private let kTokenSessionAccessTokenExpireCookieName: String = "scmp_at_exp"
//private let kTokenSessionScmpUser: String = "scmp_user"
//private let kTokenSessionCSRF8TokenCookieName: String = "CSRF8"
//private let kTokenSessionCSRF8JTokenCookieName: String = "CSRF8J"
//private let kTokenSessionPianoUserTokenCookieName: String = "scmp_pat"
//
//struct AccountSessionCookieProperties: AccountSessionVisitorType {
//  func forDrupalSession(_ session: DrupalSession) -> [[HTTPCookiePropertyKey: Any]] {
//    return [
//      // CSRF
//      [
//        .name: kTokenSessionCSRF8TokenCookieName,
//        .value: session.csrfToken
//      ],
//      [
//        .name: session.name,
//        .value: session.id
//      ]
//    ]
//  }
//
//  func forTokenSession(_ session: TokenSession) -> [[HTTPCookiePropertyKey: Any]] {
//    var cookies: [[HTTPCookiePropertyKey: Any]] =
//    [
//      [
//        .name: kTokenSessionAccessTokenCookieName,
//        .value: session.accessToken
//      ],
//      [
//        .name: kTokenSessionRefreshTokenCookieName,
//        .value: session.refreshToken
//      ],
//      [
//        .name: kTokenSessionCSRF8JTokenCookieName,
//        .value: session.csrfToken
//      ]
//    ]
//
//    if let value = session.user {
//      cookies.append([
//        .name: kTokenSessionScmpUser,
//        .value: value
//      ])
//    }
//
//    if let value = session.pianoUserToken {
//      cookies.append([
//        .name: kTokenSessionPianoUserTokenCookieName,
//        .value: value
//      ])
//    }
//
//    if let tokenExp = session.accessTokenExp {
//      cookies.append(
//        [
//          .name: kTokenSessionAccessTokenExpireCookieName,
//          .value: tokenExp
//        ]
//      )
//    }
//
//    return cookies
//  }
//}
