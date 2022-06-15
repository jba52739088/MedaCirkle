//
//  CircleHeaderItem.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/15.
//

import UIKit
import TinyConstraints

class CircleHeaderItem: CircleBaseItem {
    let container = UIView().then {
        $0.backgroundColor = .normalLightBg
    }
    private lazy var closeButton: UIButton = .closeButton(target: self, action: #selector(didTapCloseButton))
    private lazy var menuButton: UIButton = .menuButton(target: self, action: #selector(didTapMenuButton))
    let avatar = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    let authorLabel = UILabel().then {
        $0.numberOfLines = 1
    }
    let medalImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    let rankLabel = UILabel().then {
        $0.numberOfLines = 1
    }
    let dateLabel = UILabel().then {
        $0.numberOfLines = 1
    }
    let titleLabel = UILabel().then {
        $0.numberOfLines = 2
    }

    override func setup() {
        self.backgroundColor = .clear
        
        container.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
            $0.topToSuperview()
            $0.leftToSuperview()
            $0.rightToSuperview()
            $0.bottomToSuperview()
            $0.width(UIScreen.main.bounds.width)
        }
        
        avatar.do {
            container.addSubview($0)
            $0.height(43)
            $0.width(43)
            $0.topToSuperview(offset: 13)
            $0.leftToSuperview(offset: 12)
        }
        
        closeButton.do {
            container.addSubview($0)
            $0.height(30)
            $0.width(30)
            $0.centerY(to: avatar)
            $0.rightToSuperview(offset: -12)
        }
        
        menuButton.do {
            container.addSubview($0)
            $0.height(30)
            $0.width(30)
            $0.centerY(to: avatar)
            $0.rightToLeft(of: closeButton, offset: -12)
        }
        
        authorLabel.do {
            container.addSubview($0)
            $0.leftToRight(of: avatar, offset: 7)
            $0.rightToLeft(of: menuButton, offset: -10, relation: .equalOrLess)
            $0.top(to: avatar)
        }
        
        medalImage.do {
            container.addSubview($0)
            $0.height(20)
            $0.width(12)
            $0.bottom(to: avatar)
            $0.leftToRight(of: avatar, offset: 7)
        }
        
        rankLabel.do {
            container.addSubview($0)
            $0.centerY(to: medalImage)
            $0.leftToRight(of: medalImage, offset: 3)
        }
        
        let dot = UIView()
        dot.do {
            container.addSubview($0)
            $0.height(4)
            $0.width(4)
            $0.centerY(to: medalImage)
            $0.leftToRight(of: rankLabel, offset: 5)
            $0.backgroundColor = .dotBlack
        }
        
        dateLabel.do {
            container.addSubview($0)
            $0.centerY(to: medalImage)
            $0.leftToRight(of: dot, offset: 5)
            $0.rightToLeft(of: menuButton, offset: -10, relation: .equalOrLess)
        }
        
        let separator = UIView()
        separator.do {
            container.addSubview($0)
            $0.topToSuperview(offset: 70)
            $0.leftToSuperview()
            $0.rightToSuperview()
            $0.bottomToSuperview()
            $0.height(1)
            $0.backgroundColor = .separator
        }
        
//        titleLabel.do {
//            container.addSubview($0)
//            $0.leftToSuperview(offset: 15)
//            $0.rightToSuperview(offset: -15)
//            $0.topToBottom(of: separator, offset: 14.5)
//        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
        layer.masksToBounds = true
        avatar.layer.cornerRadius = 21.5
        avatar.layer.masksToBounds = true
    }
    
    override func didUpdate(viewModel: CircleBaseItemViewModel?) {
        guard let viewModel = viewModel as? CircleHeaderItemViewModel else { return }
        avatar.image = R.image.img_avatar_1()
        medalImage.image = R.image.icon_medal_1()
        authorLabel.attributedText = viewModel.authorAttributedString
        rankLabel.attributedText = viewModel.rankAttributedString
        dateLabel.attributedText = viewModel.dateAttributedString
        titleLabel.attributedText = viewModel.titleAttributedString
    }
    
    @objc func didTapCloseButton() {
        print("didTapCloseButton")
        sceneCoordinator.dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapMenuButton() {
        print("didTapMenuButton")
    }
}

