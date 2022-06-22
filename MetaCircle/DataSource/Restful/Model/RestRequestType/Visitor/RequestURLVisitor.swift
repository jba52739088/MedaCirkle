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

  func forRegisterSendMail(_ request: RegisterSendMailRequest) -> ResultType {
    return configuration.restAPIUrl
  }

  func forRegisterReSendMail(_ request: RegisterReSendMailRequest) -> ResultType {
    return configuration.restAPIUrl
  }

  func forRegisterVerifyMail(_ request: RegisterVerifyMailRequest) -> ResultType {
    return configuration.restAPIUrl
  }

  func forRegisterSendSMS(_ request: RegisterSendSMSRequest) -> ResultType {
    return configuration.restAPIUrl
  }

  func forRegisterReSendSMS(_ request: RegisterReSendSMSRequest) -> ResultType {
    return configuration.restAPIUrl
  }

  func forRegisterVerifyPhone(_ request: RegisterVerifyPhoneRequest) -> ResultType {
    return configuration.restAPIUrl
  }

  func forRegister(_ request: RegisterRequest) -> ResultType {
    return configuration.restAPIUrl
  }
}

