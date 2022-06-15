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

class CircleViewController: BaseViewController {
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
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
    
    init(_ viewModel: CircleViewModel = CircleViewModel()) {
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
            $0.register(CircleHeaderItem.self, forCellWithReuseIdentifier: "Cell")
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
        let model = TempCircleModel(image: R.image.img_circle_avatar_1(), title: "幸福幸福私立大學", subTitle: "成員1.2K人", verified: true, badgeCount: 1200, privacyType: .WholePublic)
        viewModel.datasRelay
            .map { $0.compactMap { _ in CircleHeaderItemViewModel(data: model) }}
          .bind(to: collectionView.rx.items) { (collectionView, row, element) in
            let indexPath = IndexPath(row: row, section: 0)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CircleHeaderItem
            cell.viewModel = element
            return cell
          }
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
