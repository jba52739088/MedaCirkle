//
//  RequestTaskVisitor.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/22.
//

import Moya

struct RequestTaskVisitor: RestRequestVisitorType {

  typealias ResultType = Task

  let configuration: RestTargetConfiguration

  func forRegisterSendMail(_ request: RegisterSendMailRequest) -> ResultType {
    let params: [String: String] = [
      "mail": request.mail,
      "password": request.password
    ]
    return .requestJSONEncodable(params)
  }

  func forRegisterReSendMail(_ request: RegisterReSendMailRequest) -> ResultType {
    let params: [String: String] = [
      "token": request.token
    ]
    return .requestJSONEncodable(params)
  }

  func forRegisterVerifyMail(_ request: RegisterVerifyMailRequest) -> ResultType {
    let params: [String: String] = [
      "token": request.token,
      "code": request.code
    ]
    return .requestJSONEncodable(params)
  }

  func forRegisterSendSMS(_ request: RegisterSendSMSRequest) -> ResultType {
    let params: [String: String] = [
      "token": request.token,
      "mobile": request.mobile
    ]
    return .requestJSONEncodable(params)
  }

  func forRegisterReSendSMS(_ request: RegisterReSendSMSRequest) -> ResultType {
    let params: [String: String] = [
      "token": request.token
    ]
    return .requestJSONEncodable(params)
  }

  func forRegisterVerifyPhone(_ request: RegisterVerifyPhoneRequest) -> ResultType {
    let params: [String: String] = [
      "token": request.token,
      "code": request.code
    ]
    return .requestJSONEncodable(params)
  }

  func forRegister(_ request: RegisterRequest) -> ResultType {
    let params: [String: String] = [
      "token": request.token,
      "name": request.name,
      "gender": request.gender,
      "birthday": request.birthday
    ]
    return .requestJSONEncodable(params)
  }
  
}

