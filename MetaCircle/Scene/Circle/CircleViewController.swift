//
//  CircleViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/14.
//

import UIKit
import TinyConstraints
import RxSwift
import RxCocoa
import RxDataSources


let tempCircleModel = TempCircleModel(image: R.image.img_circle_avatar_1(), title: "幸福幸福私立大學", subTitle: "成員1.2K人", verified: true, badgeCount: 1200, privacyType: .WholePublic)

class CircleViewController: BaseViewController {


  private lazy var collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    flowLayout.minimumLineSpacing = 0
    return UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
  }()
  let toolBar = UIView().then {
    $0.backgroundColor = .normalLightBg
  }

  private lazy var awesomeButton: UIButton = .menuButton(target: self, action: #selector(didTapAwesomeButton))
  private lazy var replyButton: UIButton = .menuButton(target: self, action: #selector(didTapReplyButton))
  private lazy var bookmarkButton: UIButton = .menuButton(target: self, action: #selector(didTapBookmarkButton))
  private lazy var shareButton: UIButton = .menuButton(target: self, action: #selector(didTapShareButton))
  private lazy var giftButton: UIButton = .menuButton(target: self, action: #selector(didTapGiftButton))

  let viewModel: CircleViewModel

  init(_ viewModel: CircleViewModel = CircleViewModel(data: tempCircleModel)) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    disposeBag = DisposeBag()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupView()
    didUpdateViewModel()
  }

  private func setupView() {
    toolBar.do {
      view.addSubview($0)
      $0.bottomToSuperview(usingSafeArea: true)
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.height(50)
    }

    collectionView.do {
      view.addSubview($0)
      $0.topToSuperview(usingSafeArea: true)
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.bottomToTop(of: toolBar)
      $0.register(CircleArticleTitleItem.self, forCellWithReuseIdentifier: "titleCell")
      $0.register(CircleArticleHeaderItem.self, forCellWithReuseIdentifier: "headerCell")
      $0.register(CircleArticleItem.self, forCellWithReuseIdentifier: "articleCell")
      $0.register(CircleArticleTagItem.self, forCellWithReuseIdentifier: "tagCell")

    }

    UIView().do {
      toolBar.addSubview($0)
      $0.topToSuperview()
      $0.leftToSuperview(offset: 0)
      $0.rightToSuperview(offset: 0)
      $0.height(1)
      $0.backgroundColor = .separator
    }

    awesomeButton.do {
      toolBar.addSubview($0)
      $0.setImage(R.image.icon_awesome_26(), for: .normal)
      $0.height(26)
      $0.width(26)
      $0.centerYToSuperview()
      $0.leftToSuperview(offset: 15)
    }

    replyButton.do {
      toolBar.addSubview($0)
      $0.setImage(R.image.icon_reply_26(), for: .normal)
      $0.height(26)
      $0.width(26)
      $0.centerY(to: awesomeButton)
      $0.leftToRight(of: awesomeButton, offset: 15)
    }

    bookmarkButton.do {
      toolBar.addSubview($0)
      $0.setImage(R.image.icon_bookmark_26(), for: .normal)
      $0.height(26)
      $0.width(26)
      $0.centerY(to: awesomeButton)
      $0.leftToRight(of: replyButton, offset: 15)
    }

    shareButton.do {
      toolBar.addSubview($0)
      $0.setImage(R.image.icon_share_01_26(), for: .normal)
      $0.height(26)
      $0.width(26)
      $0.centerY(to: awesomeButton)
      $0.rightToSuperview(offset: -15)
    }

    giftButton.do {
      toolBar.addSubview($0)
      $0.setImage(R.image.icon_gift_line_26(), for: .normal)
      $0.height(26)
      $0.width(26)
      $0.centerY(to: awesomeButton)
      $0.rightToLeft(of: shareButton, offset: -15)
    }

  }

  private func didUpdateViewModel() {

    let dataSource = RxCollectionViewSectionedReloadDataSource<CircleSection>(
      configureCell: { (dataSource, collectionView, indexPath, element) in
        if let vm = element as? CircleArticleTitleItemViewModel,
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "titleCell",
                                                         for: indexPath) as? CircleArticleTitleItem{
          cell.viewModel = vm
          return cell
        } else if let vm = element as? CircleArticleHeaderItemViewModel,
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "headerCell",
                                                                for: indexPath) as? CircleArticleHeaderItem {
          cell.viewModel = vm
          return cell
        } else if let vm = element as? CircleArticleItemViewModel,
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCell",
                                                                for: indexPath) as? CircleArticleItem {
          cell.viewModel = vm
          return cell
        } else if let vm = element as? CircleArticleTagItemViewModel,
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCell",
                                                                for: indexPath) as? CircleArticleTagItem {
          cell.viewModel = vm
          return cell
        }
        return UICollectionViewCell()
      })

    viewModel.itemRelay
      .bind(to: collectionView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)

  }
}

extension CircleViewController {

  @objc func didTapAwesomeButton() {
    print("didTapAwesomeButton")
  }

  @objc func didTapReplyButton() {
    print("didTapReplyButton")
  }

  @objc func didTapBookmarkButton() {
    print("didTapBookmarkButton")
  }

  @objc func didTapShareButton() {
    print("didTapShareButton")
  }

  @objc func didTapGiftButton() {
    print("didTapGiftButton")
  }
}
