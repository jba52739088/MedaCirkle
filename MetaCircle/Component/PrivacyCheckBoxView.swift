//
//  CheckBoxView.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/6/5.
//

import UIKit
import TinyConstraints
import Then
import SwiftRichString
import RxSwift
import RxGesture

protocol PrivacyCheckBoxDelegate {
  func didSelect(_ view: PrivacyCheckBoxView)
}

class PrivacyCheckBoxView: UIView {

  private let checkBtn = UIButton().then {
    $0.isUserInteractionEnabled = false
  }
  private let iconImgView = UIImageView().then {
    $0.contentMode = .scaleToFill
  }
  private let titleLabel = UILabel()
  private let subtitleLabel = UILabel()

  var didSelected: Bool = false {
    didSet {
      self.checkBtn.isSelected = didSelected
    }
  }
  var disposeBag = DisposeBag()
  let privacy: CircleCreateViewModel.Privacy
  let delegate: PrivacyCheckBoxDelegate?

  init(privacy: CircleCreateViewModel.Privacy, delegate: PrivacyCheckBoxDelegate? = nil) {
    self.privacy = privacy
    self.delegate = delegate
    super.init(frame: CGRect.zero)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    disposeBag = DisposeBag()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    setupViews()
  }

  func setupViews() {
    backgroundColor = .clear
    checkBtn.do {
      self.addSubview($0)
      $0.setImage(R.image.radio_button_1(), for: .normal)
      $0.setImage(R.image.radio_button_1_selected(), for: .selected)
      $0.centerYToSuperview()
      $0.leftToSuperview(offset: 14)
      $0.height(25)
      $0.width(25)
    }

    iconImgView.do {
      self.addSubview($0)
      $0.topToSuperview(offset: 11)
      $0.leftToRight(of: checkBtn, offset: 8)
      $0.height(25)
      $0.width(25)
      iconImgView.image = privacy.image
    }

    titleLabel.do {
      self.addSubview($0)
      $0.topToSuperview(offset: 10)
      $0.leftToRight(of: iconImgView, offset: 6)
      $0.rightToSuperview(offset: -6, relation: .equalOrGreater)
      $0.attributedText = self.titleAttributedString
    }

    subtitleLabel.do {
      self.addSubview($0)
      $0.bottomToSuperview(offset: -10)
      $0.leftToRight(of: checkBtn, offset: 8)
      $0.rightToSuperview(offset: -6, relation: .equalOrGreater)
      $0.attributedText = self.subtitleAttributedString
    }

    self.rx.tapGesture()
      .when(.recognized)
      .subscribe(onNext: { [weak self] _ in
        guard let self = self else { return }
        self.delegate?.didSelect(self)
      })
      .disposed(by: disposeBag)
  }

}

private
extension PrivacyCheckBoxView {
  var titleAttributedString: NSAttributedString {
    return privacy.string.set(style: titleTextStyle)
  }

  var subtitleAttributedString: NSAttributedString {
    return privacy.description.set(style: subtitleTextStyle)
  }


  var titleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCMedium(size: 18)
      $0.maximumLineHeight = 27
      $0.minimumLineHeight = 27
      $0.color = UIColor.normalText
    }
  }

  var subtitleTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 16)
      $0.maximumLineHeight = 24
      $0.minimumLineHeight = 24
      $0.color = UIColor.hintTextGray
    }
  }
}
