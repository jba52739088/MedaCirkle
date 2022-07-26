//
//  MetaTextField.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/26.
//


import UIKit
import TinyConstraints
import Then
import RxSwift
import RxCocoa

class MetaTextField: UIView {

  var placeholder: NSAttributedString? {
    didSet {
      txtField.attributedPlaceholder = placeholder
    }
  }

  var showButton: Bool = false {
    didSet {
      setupViews()
    }
  }

  let txtBgView = UIView().then {
    $0.backgroundColor = .textFieldNormalBg
  }

  private(set) var txtView = UIView().then {
    $0.backgroundColor = .clear
  }

  private(set) var fieldButton = UIButton(type: .custom)

  private(set) var txtField = UITextField().then {
    $0.borderStyle = .none
  }

  private var disposeBag = DisposeBag()

  init() {
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
    configFieldEvent()
  }

  func setupViews() {
    backgroundColor = .clear

    txtBgView.do {
      self.addSubview($0)
      $0.height(44)
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.bottomToSuperview()
      $0.layer.cornerRadius = 15
      $0.layer.masksToBounds = true
    }

    txtView.do {
      txtBgView.addSubview($0)
      $0.topToSuperview(offset: 2)
      $0.bottomToSuperview(offset: -2)
      $0.leftToSuperview(offset: 2)
      $0.rightToSuperview(offset: -2)
      $0.layer.cornerRadius = 13
      $0.layer.masksToBounds = true
    }

    if showButton {
      fieldButton.do {
        txtView.addSubview($0)
        $0.height(20)
        $0.width(20)
        $0.rightToSuperview(offset: -17)
        $0.centerYToSuperview()
        $0.setImage(R.image.icon_eyes_2(), for: .normal)
        $0.setImage(R.image.icon_eyes_3(), for: .selected)
        $0.addTarget(self, action: #selector(onClickFieldButton(_:)), for: .touchUpInside)
      }
    } else {
      fieldButton.removeFromSuperview()
    }


    txtField.do {
      txtView.addSubview($0)
      $0.topToSuperview(offset: 9.5)
      $0.leftToSuperview(offset: 17)
      if showButton {
        $0.rightToLeft(of: fieldButton, offset: -10)
      } else {
        $0.rightToSuperview(offset: 17)
      }
      $0.bottomToSuperview(offset: -9.5)
      $0.textAlignment = .left
      $0.contentVerticalAlignment = .center
    }
  }

  func configFieldEvent() {

    txtField.rx.controlEvent(.editingDidBegin)
      .asObservable()
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        self.txtBgView.applyGradient(isVertical: false, colorArray: [.tabbarGradientYellow, .tabbarGradientPurple, .tabbarGradientBlue])
        self.txtView.backgroundColor = .white
      })
      .disposed(by: disposeBag)

    txtField.rx.controlEvent(.editingDidEnd)
      .asObservable()
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        self.txtBgView.removeGradient()
        self.txtBgView.backgroundColor = .textFieldNormalBg
        self.txtView.backgroundColor = .clear
      })
      .disposed(by: disposeBag)
  }

  @objc
  func onClickFieldButton(_ sender: UIButton) {
    sender.isSelected = !sender.isSelected

  }
}
