//
//  VerifyModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/22.
//

import Foundation

class VerifyModel {
  var token: String
  var cooldown: String

  init(token: String, cooldown: String) {
    self.token = token
    self.cooldown = cooldown
  }
}

class VerifyMailModel: VerifyModel {
  let mail: String

  init(mail: String, token: String, cooldown: String) {
    self.mail = mail
    super.init(token: token, cooldown: cooldown)

  }
}

class VerifyPhoneModel: VerifyModel {
  let phone: String

  init(phone: String, token: String, cooldown: String) {
    self.phone = phone
    super.init(token: token, cooldown: cooldown)

  }
}
