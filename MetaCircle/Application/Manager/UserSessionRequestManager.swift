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
  let userSessionManager: UserSessionManager

  lazy var apiClient: APIClient = dataLoader()

  init(userSessionManager: UserSessionManager) {
    self.userSessionManager = userSessionManager
  }

  func updateUponEnviromentChange() {
    apiClient = dataLoader()
  }

  func registerSendMail(mail: String, password: String) -> Single<RegisterResponse?> {
//    guard let profile = currentProfile else { return .just(nil) }
    let request = RegisterSendMailRequest(mail: mail, password: password)
    return apiClient.send(request: request).asSingle()
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
//  private func requestProfile(fromNonce nonce: Observable<NonceResponse>) -> Single<UserProfile> {
//    return nonce.asSingle()
//    .flatMap({ [weak self] result -> Single<UserProfile> in
//      guard let self = self else { throw RestApiError.clientDeallocated }
//      return self.apiClient.send(request: result.asProfileRequest).asSingle()
//    })
//  }
//
//  func signIn(username: String, password: String) -> Single<UserProfile> {
//    let request = EmailSignInRequest(userName: username, password: password)
//    return requestProfile(fromNonce: apiClient.send(request: request))
//      .map({ val in
//        var profile = val
//        profile.signInSource = .email
//        return profile
//      })
//      .flatMap({ [weak self] profile -> Single<UserProfile> in
//        self?.postSignIn(with: profile) ?? .just(profile)
//      })
//      .do(onSuccess: { [weak self] profile in
//        self?.onSignInSuccess(with: profile)
//        self?.lastLoginUsername = username
//      })
//  }
//
//  /// Sign in with facebook
//  func facebookSignIn(accessToken: String, email: String) -> Single<UserProfile> {
//    let request = FacebookSignInRequest(session: nil, accessToken: accessToken, email: email)
//    return requestProfile(fromNonce: apiClient.send(request: request))
//      .map({ val in
//        var profile = val
//        profile.signInSource = .facebook
//        return profile
//      })
//      .flatMap({ [weak self] profile -> Single<UserProfile> in
//        self?.postSignIn(with: profile) ?? .just(profile)
//      })
//      .do(onSuccess: { [weak self] profile in
//        self?.onSignInSuccess(with: profile)
//        self?.lastLoginUsername = nil
//      })
//  }
//
//  /// Sign in with google
//  func googleSignIn(accessToken: String, email: String) -> Single<UserProfile> {
//    let request = GoogleSignInRequest(session: nil, accessToken: accessToken, email: email)
//    return requestProfile(fromNonce: apiClient.send(request: request))
//      .map({ val in
//        var profile = val
//        profile.signInSource = .google
//        return profile
//      })
//      .flatMap({ [weak self] profile -> Single<UserProfile> in
//        self?.postSignIn(with: profile) ?? .just(profile)
//      })
//      .do(onSuccess: { [weak self] profile in
//        self?.onSignInSuccess(with: profile)
//        self?.lastLoginUsername = nil
//      })
//  }
//
//  func appleSignIn(jwt: String, firstName: String, lastName: String, optin: Bool) -> Single<UserProfile> {
//    let request = AppleSignInRequest(jwt: jwt, firstName: firstName, lastName: lastName, optin: optin)
//
//    return requestProfile(fromNonce: apiClient.send(request: request))
//      .map({ val in
//        var profile = val
//        profile.signInSource = .apple
//        return profile
//      })
//      .flatMap({ [weak self] profile -> Single<UserProfile> in
//        self?.postSignIn(with: profile) ?? .just(profile)
//      })
//      .do(onSuccess: { [weak self] profile in
//        self?.onSignInSuccess(with: profile)
//        self?.lastLoginUsername = nil
//      })
//  }
//
//  /// Connect facebook
//  func facebookConnect(accessToken: String, email: String) -> Completable {
//    let request = FacebookSignInRequest(
//      session: currentProfile?.session, accessToken: accessToken, email: email)
//
//    return apiClient.send(request: request).asSingle().asCompletable()
//  }
//
//  /// Connect facebook
//  func googleConnect(accessToken: String, email: String) -> Completable {
//    let request = GoogleSignInRequest(
//      session: currentProfile?.session, accessToken: accessToken, email: email)
//    return apiClient.send(request: request).asSingle().asCompletable()
//  }
//
//  func signOut() -> Completable {
//    guard let profile = currentProfile else { return .empty() }
//
//    let request = SignOutRequest(session: profile.session)
//    return Completable.zip([
//      clearSettingsForSignOut(),
//      apiClient.send(request: request).asSingle().asCompletable()
//        .catchError({ _ in .empty() })
//    ])
//    .timeout(.seconds(2), scheduler: MainScheduler.instance)
//  }
//
//  func signUp(username: String, password: String, isReceiveAdvertisment: Bool) -> Single<SignUpResponse> {
//    let request = EmailSignUpRequest(
//      email: username,
//      password: password,
//      avatar: nil,
//      isMarketingAllowed: isReceiveAdvertisment)
//
//    return apiClient.send(request: request)
//      .asSingle()
//      .do(
//        afterSuccess: { [weak self] _ in
//          self?.lastLoginUsername = username
//        },
//        afterError: { [weak self] _ in
//          self?.lastLoginUsername = username
//        }
//      )
//  }
//
//  func signUpByPasswordless(email: String, optin: Bool = false, newsletterId: String = "") -> Single<Void> {
//    let request = PasswordlessSignUpRequest(
//      email: email,
//      createAccount: true,
//      optin: optin,
//      newsletterId: newsletterId)
//
//    return apiClient
//      .send(request: request)
//      .voidify()
//      .asSingle()
//  }
//
//  func checkEmailSignInMethod(email: String) -> Single<PasswordlessSignUpResponse> {
//    let request = PasswordlessSignUpRequest(
//      email: email,
//      createAccount: false,
//      optin: false,
//      newsletterId: "")
//
//    return apiClient
//      .send(request: request)
//      .asSingle()
//  }
//
//  func resetPassword(username: String) -> Completable {
//    let request = ResetPasswordRequest(email: username)
//    return apiClient.send(request: request)
//      .asSingle().asCompletable()
//  }
//
//  func resendActivationEmail(_ email: String) -> Single<ResendActivationEmailResponse> {
//    let request = ResendActivationRequest(email: email)
//    return apiClient.send(request: request).asSingle()
//  }
//
//  func refreshUserProfile(profile: UserProfile) -> Single<UserContext?> {
//    return apiClient.userProfile(uid: profile.id)
//      .do(onSuccess: { [weak self] userContext in
//        guard let self = self, let userContext = userContext, userContext.uuid != Globals.kAnonymousUserId, var _profile = self.currentProfile else { return }
//
//        if let uuid = userContext.uuid {
//          _profile.uuid = uuid
//        }
//        _profile.username = userContext.name
//
//        if let avatarUrlStr = userContext.reverseUidProfile.userPhoto.first {
//          _profile.avatar = UserProfile.Avatar(urlString: avatarUrlStr, urlStringMQ: avatarUrlStr)
//        }
//
//        _profile.firstName = userContext.reverseUidProfile.firstName
//        _profile.lastName = userContext.reverseUidProfile.lastName
//        _profile.profileId = userContext.reverseUidProfile.profileId
//        _profile.fieldContentRelatedOptIn = userContext.reverseUidProfile.fieldContentRelatedOptIn
//        _profile.socialConnected = userContext
//          .reverseUserIdSocialAuth
//          .map({ SocialMediaConnect(socialMediaData: $0) })
//
//        _profile.newsletterSubscribed = userContext
//          .reverseUidSimplenewsSubscriber
//          .compactMap({ subscriber -> [NewsletterSubscription] in
//            return subscriber
//              .subscriptions
//              .compactMap({ sub in
//                guard sub.status == 1 else { return nil }
//                return NewsletterSubscription(context: sub)
//              })
//          })
//          .flatMap({ $0 })
//        self.currentProfile = _profile
//      })
//  }
//
//  func deleteSocialMediaConnection(socialMediaId: String) -> Single<Bool> {
//    return apiClient.deleteSocialMediaConnection(socialMediaId: socialMediaId)
//      .do(onSuccess: { [weak self] success in
//        guard let self = self else { return }
//        if success {
//          var profile = self.currentProfile
//
//          profile?.socialConnected.removeAll(where: { $0.id == socialMediaId })
//          self.currentProfile = profile
//        }
//      })
//  }
//
//  func signOutAnonymousUserIfNeeded() -> Completable {
//    guard let profile = currentProfile else { return .empty() }
//    if profile.uuid == Globals.kAnonymousUserId {
//      return clearSettingsForSignOut()
//
//    } else {
//      return .empty()
//    }
//  }

//  func deleteAccount() -> Single<DeleteAccountResponse?> {
//    guard let profile = currentProfile else { return .just(nil) }
//    let request = DeleteAccountRequest(uuid: profile.uuid, session: profile.session)
//    return apiClient.send(request: request).asSingle()
//  }

//  // MARK: -
//
//  private func postSignIn(with profile: UserProfile) -> Single<UserProfile> {
//    UserSessionRequestManager.retrievePianoUserTokenIfNeeded(with: profile)
//      .catchErrorJustReturn(profile)
//      .flatMap({ _profile -> Single<UserProfile> in
//        let token = (_profile.session as? TokenSession)?.pianoUserToken
//        return MainAppService.shared.paywallService.updatePianoUserToken(token)
//          .andThen(Single<UserProfile>.just(_profile))
//          .catchErrorJustReturn(_profile)
//      })
//  }
//
//  private func onSignInSuccess(with profile: UserProfile) {
//    currentProfile = profile
//    _ = MainAppService.shared.bookmarkManager.fetchBookmarkFullList().subscribe()
//    _ = MainAppService.shared.paywallService.pianoService.retrieveSubsciptions().subscribe()
//
//    let event = SignInEvent(signInSource: profile.signInSource)
//    Tracker.shared.setMixpanelSuperProperty(event.signInSource.asMixpanelProperty)
//    Tracker.shared.trackEvent(event: event)
//  }
//
//  private func clearSettingsForSignOut() -> Completable {
//    return Completable.zip([
//      MainAppService.shared.paywallService.updatePianoUserToken(nil)
//        .catchError({ _ in .empty() }),
//      Completable.create(subscribe: { [weak self] observer -> Disposable in
//        MainAppService.shared.bookmarkManager.clearLocalBookmark()
//        self?.currentProfile = nil
//        observer(.completed)
//        return Disposables.create()
//      })
//    ])
//  }
//
//  // MARK: - Piano
//
//  static func retrieveUserToken(using session: UserSession) -> Single<String> {
//    dataLoader()
//      .send(request: PianoJWTRequest(session: session))
//      .asSingle()
//  }
//
//  private static func retrievePianoUserTokenIfNeeded(with profile: UserProfile) -> Single<UserProfile> {
//    if var sess = profile.session as? TokenSession, sess.pianoUserToken == nil {
//      return retrieveUserToken(using: profile.session)
//        .map({ token in
//          var _profile = profile
//          sess.pianoUserToken = token
//          _profile.session = sess
//          return _profile
//        })
//    }
//
//    return .just(profile)
//  }
//
//  func retrievePianoUserTokenIfNeeded() -> Single<UserProfile?> {
//    if let profile = currentProfile {
//      return UserSessionRequestManager.retrievePianoUserTokenIfNeeded(with: profile)
//        .do(onSuccess: { [weak self] profile in
//          self?.currentProfile = profile
//        })
//        .map({ $0 as UserProfile? })
//    }
//
//    return .just(nil)
//  }
//
//  // MARK: -
//
//  func setCurrentProfileExpireFromDebugMenu(dummyProfile: UserProfile) {
//    #if DEBUG
//    // Signout and do nothing
//    let request = SignOutRequest(session: dummyProfile.session)
//    _ = apiClient.send(request: request).asSingle().asCompletable().subscribe()
//    #endif
//  }
//
//  func handleSessionExpire(source: SignInFlowSource, signInCompleted: ((Bool) -> Void)?) {
//    _ = self.signOut().subscribe()
//    DispatchQueue.main.async { [weak self] in
//      guard let self = self else { return }
//      self.requestSignIn(source: source, completion: { complete in
//        signInCompleted?(complete)
//      })
//    }
//  }
//
//  // MARK: - handle 'deleted' token in user profile
//  func signOutIfSessionDeleted() -> Completable {
//    guard let tokenSession = self.currentProfile?.session as? TokenSession,
//      tokenSession.isTokenMarkDeleted() else { return .empty() }
//    return clearSettingsForSignOut()
//  }
}

//// MARK: - Helper
//
//extension UserSessionRequestManager {
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
//}
//
//// MARK: - Token Refreshing
//
//extension UserSessionRequestManager {
//  func refreshTokensIfNeeded() -> Completable {
//    guard let profile = currentProfile, let tokenSession = profile.session as? TokenSession else { return Completable.empty() }
//
//    let request = RefreshTokensV1Request(token: tokenSession)
//
//    return apiClient.send(request: request).asSingle()
//      .do(onSuccess: { [weak self] meta in
//        guard let self = self else { return }
//
//        if let session = createTokenSession(from: meta, basedOn: self.currentProfile?.session) {
//          self.userSessionManager.updateSessionIfNeeded(session: session)
//        }
//      }, onError: { _ in
//        // MARK: template disbale sign out function
////        if case RestApiError.sessionExpire = error {
////          self?.handleSignOut()
////        }
//      })
//      .asCompletable()
//  }
//}
