//
//  RequestURLVisitor.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/22.
//

import Foundation

struct RequestURLVisitor: RestRequestVisitorType {

  typealias ResultType = URL

  let configuration: RestTargetConfiguration

  //MARK: Login
  func forLogin(_ request: LoginRequest) -> ResultType { configuration.restAPIUrl }
  func forLogout(_ request: LogoutRequest) -> ResultType { configuration.restAPIUrl }

  //MARK: Register
  func forRegisterSendMail(_ request: RegisterSendMailRequest) -> ResultType { configuration.restAPIUrl }
  func forRegisterReSendMail(_ request: RegisterReSendMailRequest) -> ResultType { configuration.restAPIUrl }
  func forRegisterVerifyMail(_ request: RegisterVerifyMailRequest) -> ResultType { configuration.restAPIUrl }
  func forRegisterSendSMS(_ request: RegisterSendSMSRequest) -> ResultType { configuration.restAPIUrl }
  func forRegisterReSendSMS(_ request: RegisterReSendSMSRequest) -> ResultType { configuration.restAPIUrl }
  func forRegisterVerifyPhone(_ request: RegisterVerifyPhoneRequest) -> ResultType { configuration.restAPIUrl }
  func forRegister(_ request: RegisterRequest) -> ResultType { configuration.restAPIUrl }
}

