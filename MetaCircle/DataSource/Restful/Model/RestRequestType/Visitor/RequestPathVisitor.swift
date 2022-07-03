//
//  RequestPathVisitor.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/22.
//

import Foundation

struct RequestPathVisitor: RestRequestVisitorType {

  typealias ResultType = String

  let configuration: RestTargetConfiguration
  
  //MARK: Login
  func forLogin(_ request: LoginRequest) -> ResultType {
    "api/login"
  }

  func forLogout(_ request: LogoutRequest) -> ResultType {
    "api/logout"
  }

  //MARK: Register
  func forRegisterSendMail(_ request: RegisterSendMailRequest) -> ResultType {
    "api/register/send-mail"
  }

  func forRegisterReSendMail(_ request: RegisterReSendMailRequest) -> ResultType {
    "api/register/resend-mail"
  }

  func forRegisterVerifyMail(_ request: RegisterVerifyMailRequest) -> ResultType {
    "api/register/verify-mail"
  }

  func forRegisterSendSMS(_ request: RegisterSendSMSRequest) -> ResultType {
    "api/register/send-sms"
  }

  func forRegisterReSendSMS(_ request: RegisterReSendSMSRequest) -> ResultType {
    "api/register/resend-sms"
  }

  func forRegisterVerifyPhone(_ request: RegisterVerifyPhoneRequest) -> ResultType {
    "api/register/verify-mobile"
  }

  func forRegister(_ request: RegisterRequest) -> ResultType {
    "api/register"
  }


}
