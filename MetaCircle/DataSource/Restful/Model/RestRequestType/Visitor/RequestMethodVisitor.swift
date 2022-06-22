//
//  RequestMethodVisitor.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/22.
//

import Moya

struct RequestMethodVisitor: RestRequestVisitorType {

  typealias ResultType = Moya.Method

  func forRegisterSendMail(_ request: RegisterSendMailRequest) -> ResultType { .post }
  func forRegisterReSendMail(_ request: RegisterReSendMailRequest) -> ResultType { .post }
  func forRegisterVerifyMail(_ request: RegisterVerifyMailRequest) -> ResultType { .post }
  func forRegisterSendSMS(_ request: RegisterSendSMSRequest) -> ResultType { .post }
  func forRegisterReSendSMS(_ request: RegisterReSendSMSRequest) -> ResultType { .post }
  func forRegisterVerifyPhone(_ request: RegisterVerifyPhoneRequest) -> ResultType { .post }
  func forRegister(_ request: RegisterRequest) -> ResultType { .post }
}
