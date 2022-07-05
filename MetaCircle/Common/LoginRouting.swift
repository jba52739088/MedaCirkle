//
//  LoginRouting.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/4.
//

import Foundation
import RxCocoa
import RxSwift

protocol LoginRouting {
  var disposeBag: DisposeBag { get }
  func doLogin(mail: String, password: String)
  func doRegisterAndLogin(token: String, name: String, gender: String, birthday: String)
  func loginSucceed(in vc: UIViewController)
  func loginFailed(in vc: UIViewController, errorCode: String?, errorMessage: String?)
}

extension LoginRouting where Self: UIViewController {
  func doLogin(mail: String, password: String) {
    MainAppService.shared
      .userSessionRequestManager
      .login(mail: mail, password: password)
      .observe(on: MainScheduler.instance)
      .do(onSuccess: ({ [weak self] reponseData in
        guard let self = self else { return }
        if let reponse = reponseData {
          if let isSucceed = reponse.success,
             isSucceed == true,
             let token = reponse.token {
            MainAppService.shared.userSessionRequestManager.currentToken = token
            MainAppService.shared.preferenceManager.lastUsername = mail
            MainAppService.shared.preferenceManager.lastPassword = password
            self.loginSucceed(in: self)
            }
          } else {
            self.loginFailed(in: self, errorCode: reponseData?.error, errorMessage: reponseData?.errors?.first?.message)
          }
      }), onError: ({ [weak self] error in
        guard let self = self else { return }
        self.loginFailed(in: self, errorCode: "", errorMessage: error.localizedDescription)
        print("error: \(error)")
      }))
      .subscribe()
      .disposed(by: disposeBag)
  }

  func doRegisterAndLogin(token: String, name: String, gender: String, birthday: String) {
    MainAppService.shared
      .userSessionRequestManager
      .register(token: token, name: name, gender: gender, birthday: birthday)
      .observe(on: MainScheduler.instance)
      .do(onSuccess: ({ [weak self] reponseData in
        guard let self = self else { return }
        if let reponse = reponseData {
          if let isSucceed = reponse.success,
             isSucceed == true,
             let token = reponse.token {
            MainAppService.shared.userSessionRequestManager.currentToken = token
            self.loginSucceed(in: self)
            }
          } else {
            self.loginFailed(in: self, errorCode: reponseData?.error, errorMessage: reponseData?.errors?.first?.message)
          }
      }), onError: ({ [weak self] error in
        guard let self = self else { return }
        self.loginFailed(in: self, errorCode: "", errorMessage: error.localizedDescription)
        print("error: \(error)")
      }))
      .subscribe()
      .disposed(by: disposeBag)
  }
}
