//
//  RestRequestVisitorType.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/19.
//

import Foundation

public protocol RestRequestVisitorType {
  associatedtype ResultType

  //MARK: Register
  func forRegisterSendMail(_ request: RegisterSendMailRequest) -> ResultType
  func forRegisterReSendMail(_ request: RegisterReSendMailRequest) -> ResultType
  func forRegisterVerifyMail(_ request: RegisterVerifyMailRequest) -> ResultType
  func forRegisterSendSMS(_ request: RegisterSendSMSRequest) -> ResultType
  func forRegisterReSendSMS(_ request: RegisterReSendSMSRequest) -> ResultType
  func forRegisterVerifyPhone(_ request: RegisterVerifyPhoneRequest) -> ResultType
  func forRegister(_ request: RegisterRequest) -> ResultType

}
