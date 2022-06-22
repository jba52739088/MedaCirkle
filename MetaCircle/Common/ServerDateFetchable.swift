//
//  ServerDateFetchable.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/22.
//

import UIKit

protocol ServerDateFetchable: AnyObject {
  func fetchServerDate(from response: URLResponse?)
  func fetchServerDateFromHeader(_ header: [AnyHashable: Any])
}

extension ServerDateFetchable {

  func fetchServerDate(from response: URLResponse?) {
    let url = response?.url
    guard
      let _response = response as? HTTPURLResponse,
      let host = url?.host
    else { return }
//    if isUnderDomain(host: host) {
//      fetchServerDateFromHeader(_response.allHeaderFields)
//    }
  }

//  func fetchServerDateFromHeader(_ header: [AnyHashable: Any]) {
//    do {
//      let dateFormatter = DateFormatter()
//      let dateString = try String(jsonValue: header["Date"] ?? "")
//
//      dateFormatter.dateFormat = DateFormatter.kDateFromAPIHeaderFormat
//      guard let date = dateFormatter.date(from: dateString) else { return }
//
//      if isDateAvailableToStore(date) {
//        MainAppService.shared.preferenceManager.dateFromApiHeader = date
//        logger.debug("Store date: \(dateString)")
//      }
//    } catch {
//      logger.debug("Cannot phrase json date header")
//    }
//  }
//
//  private func isUnderDomain(host: String) -> Bool {
//    let domains = Globals.fetchDateHeaderFromDomains
//    for domain in domains {
//      if host.hasSuffix(domain) {
//        return true
//      }
//    }
//    return false
//  }
//
//  private func isDateAvailableToStore(_ date: Date) -> Bool {
//    guard let storedDate = MainAppService.shared.preferenceManager.dateFromApiHeader else { return true }
//    return date > storedDate
//  }
}

