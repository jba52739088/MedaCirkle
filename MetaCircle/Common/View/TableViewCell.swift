//
//  TableViewCell.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/31.
//

import RxSwift
import UIKit

protocol ViewModelBindable {
  associatedtype ViewModel

  func didUpdate(viewModel: Self.ViewModel?)

  var viewModel: Self.ViewModel? { get set }
}

protocol TableViewCellViewModel: AnyObject {
  func cellHeight() -> CGFloat
}

protocol HasDisposeBag: AnyObject {
  var disposeBag: DisposeBag { get set }
}

class TableViewCell<ViewModel>: UITableViewCell, ViewModelBindable, HasDisposeBag {

  var disposeBag: DisposeBag = DisposeBag()
  var maxBottomSafeArea: CGFloat = 0
  var viewModel: ViewModel? {
    didSet {
      didUpdate(viewModel: viewModel)
    }
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setup() {}

  func didUpdate(viewModel: ViewModel?) {}

  override func prepareForReuse() {
    super.prepareForReuse()

    viewModel = nil
    disposeBag = DisposeBag()
  }
}

