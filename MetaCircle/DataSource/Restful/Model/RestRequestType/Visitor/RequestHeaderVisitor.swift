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

  func forRegisterSendMail(_ request: RegisterSendMailRequest) -> ResultType {
    defaultHeader
  }

  func forRegisterReSendMail(_ request: RegisterReSendMailRequest) -> ResultType {
    defaultHeader
  }

  func forRegisterVerifyMail(_ request: RegisterVerifyMailRequest) -> ResultType {
    defaultHeader
  }

  func forRegisterSendSMS(_ request: RegisterSendSMSRequest) -> ResultType {
    defaultHeader
  }

  func forRegisterReSendSMS(_ request: RegisterReSendSMSRequest) -> ResultType {
    defaultHeader
  }

  func forRegisterVerifyPhone(_ request: RegisterVerifyPhoneRequest) -> ResultType {
    defaultHeader
  }

  func forRegister(_ request: RegisterRequest) -> ResultType {
    defaultHeader
  }

}
