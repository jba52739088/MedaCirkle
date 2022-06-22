//
//  Globals.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/22.
//

import Foundation

struct Globals {
  internal static let appVersionString: String = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String ?? ""
  internal static let buildNumberString: String = Bundle.main.infoDictionary!["CFBundleVersion"] as? String ?? ""
}
