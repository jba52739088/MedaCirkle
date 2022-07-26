//
//  ProfileViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/12.
//

import UIKit
import SwiftRichString
import RxSwift
import RxCocoa

class ProfileViewModel {

  var itemsRelay = BehaviorRelay<[ProfileCellViewModel]>(value: [])
  var disposeBag = DisposeBag()

  let profile: Profile

  deinit {
    disposeBag = DisposeBag()
  }

  init(profile: Profile) {
    self.profile = profile
    configItems()
  }

  private func configItems() {
    let items: [ProfileListItem] = ProfileListItem.allCases
    let vms = items.compactMap({ return $0.viewModel })
    self.itemsRelay.accept(vms)
  }
}
