//
//  RequestHeaderVisitor.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/22.
//

import Foundation

struct RequestHeaderVisitor: RestRequestVisitorType {

  typealias ResultType = [String: String]?

  let configuration: RestTargetConfiguration
  var defaultHeader: [String: String] {
    ["Content-Type": "application/json",
     "Accept-Encoding": "gzip, deflate, br",
     "Connection": "keep-alive"]
  }
  var tokenHeader: [String: String] {
    var header = defaultHeader
    header["Authorization"] = "Bearer \(MainAppService.shared.userSessionRequestManager.currentToken ?? "")"
    return header
  }

  //MARK: Login
  func forLogin(_ request: LoginRequest) -> ResultType { defaultHeader }
  func forLogout(_ request: LogoutRequest) -> ResultType { tokenHeader }

  //MARK: Register
  func forRegisterSendMail(_ request: RegisterSendMailRequest) -> ResultType { defaultHeader }
  func forRegisterReSendMail(_ request: RegisterReSendMailRequest) -> ResultType { defaultHeader }
  func forRegisterVerifyMail(_ request: RegisterVerifyMailRequest) -> ResultType { defaultHeader }
  func forRegisterSendSMS(_ request: RegisterSendSMSRequest) -> ResultType { defaultHeader }
  func forRegisterReSendSMS(_ request: RegisterReSendSMSRequest) -> ResultType { defaultHeader }
  func forRegisterVerifyPhone(_ request: RegisterVerifyPhoneRequest) -> ResultType { defaultHeader }
  func forRegister(_ request: RegisterRequest) -> ResultType { defaultHeader }

}
