//
//  Profile.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/4.
//

import Foundation

// MARK: - Profile
public struct Profile: Decodable {
  public var banner, avatar, nickname: String?
  public var name: String?
  public var hideName: Bool?
  public var gender: Int?
  public var hideGender: Bool?
  public var birthday: String?
  public var hideBirthday: Bool?

  enum CodingKeys: String, CodingKey {
    case banner, avatar, nickname, name
    case hideName = "hide_name"
    case gender
    case hideGender = "hide_gender"
    case birthday
    case hideBirthday = "hide_birthday"
  }
}

// MARK: - Gender
public struct Gender: Decodable {
  public var id: Int
  public var title: String
}
