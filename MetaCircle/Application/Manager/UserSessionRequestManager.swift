//
//  UserSessionRequestManager.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/22.
//

import Foundation
import RxCocoa
import RxSwift

class UserSessionRequestManager {

  var currentToken: String?

  let userSessionManager: UserSessionManager

  lazy var apiClient: APIClient = dataLoader()

  init(userSessionManager: UserSessionManager) {
    self.userSessionManager = userSessionManager
  }

  func updateUponEnviromentChange() {
    apiClient = dataLoader()
  }

  func registerSendMail(mail: String, password: String) -> Single<LoginResponse?> {
    let request = RegisterSendMailRequest(mail: mail, password: password)
    return apiClient.send(request: request).asSingle()
  }

  func registerReSendMail(token: String) -> Single<LoginResponse?> {
    let request = RegisterReSendMailRequest(token: token)
    return apiClient.send(request: request).asSingle()
  }

  func registerVerifyMail(token: String, code: String) -> Single<LoginResponse?> {
    let request = RegisterVerifyMailRequest(token: token, code: code)
    return apiClient.send(request: request).asSingle()
  }

  func registerSendSMS(mobile: String, token: String) -> Single<LoginResponse?> {
    let request = RegisterSendSMSRequest(token: token, mobile: mobile)
    return apiClient.send(request: request).asSingle()
  }

  func registerReSendSMS(token: String) -> Single<LoginResponse?> {
    let request = RegisterReSendSMSRequest(token: token)
    return apiClient.send(request: request).asSingle()
  }
  func registerVerifyPhone(token: String, code: String) -> Single<LoginResponse?> {
    let request = RegisterVerifyPhoneRequest(token: token, code: code)
    return apiClient.send(request: request).asSingle()
  }

  func register(token: String, name: String, gender: String, birthday: String) -> Single<LoginResponse?> {
    let request = RegisterRequest(token: token, name: name, gender: gender, birthday: birthday)
    return apiClient.send(request: request).asSingle()
  }


}

// MARK: - Helper

extension UserSessionRequestManager {
//  var currentProfile: UserProfile? {
//    get { return userSessionManager.currentProfile }
//    set { userSessionManager.currentProfile = newValue }
//  }
//
//  var lastLoginUsername: String? {
//    get { return userSessionManager.lastLoginUsername }
//    set { userSessionManager.lastLoginUsername = newValue }
//  }
//
//  func refreshProfileIfNeeded() {
//    guard let profile = currentProfile else { return }
//
//    _ = refreshUserProfile(profile: profile).subscribe()
//  }
}
