//
//  CollectionViewCell.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/8.
//

import RxSwift
import UIKit

protocol CollectionViewCellViewModel: AnyObject {
  var contentInsets: UIEdgeInsets { get set }
  func cellSize(for collectionViewSize: CGSize, containerInset: UIEdgeInsets) -> CGSize
}

class CollectionViewCell<ViewModel>: UICollectionViewCell, ViewModelBindable, HasDisposeBag {

  var disposeBag: DisposeBag = DisposeBag()
  var maxBottomSafeArea: CGFloat = 0
  var viewModel: ViewModel? {
    didSet {
      didUpdate(viewModel: viewModel)
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
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

