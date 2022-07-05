//
//  ProfileResponse.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/4.
//

import Foundation

// MARK: - ProfileResponse
public struct ProfileResponse: Decodable {
  public var success: Bool?
  public var genders: [Gender]?
  public var data: Profile?


}
