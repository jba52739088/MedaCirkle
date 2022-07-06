//
//  MemberViewModel.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/6.
//

import UIKit
import SwiftRichString
import RxSwift
import RxCocoa

class MemberViewModel {

  var itemsRelay = BehaviorRelay<[MemberCellViewModel]>(value: [])
  var disposeBag = DisposeBag()

  deinit {
    disposeBag = DisposeBag()
  }

  init() {
    configItems()
  }

  private func configItems() {
    let items: [MemberListItem] = [.profile, .info, .bookmark, .tag, .bigcircle, .draft, .wallet, .gift, .volume, .history, .separator, .account, .help, .setting, .separator, .logout]
    let vms = items.compactMap({ return $0.viewModel })
    self.itemsRelay.accept(vms)
  }
}
