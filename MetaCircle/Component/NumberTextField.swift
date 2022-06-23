//
//  NumberTextField.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/22.
//

import UIKit
import TinyConstraints
import Then
import RxSwift
import RxCocoa

class NumberTextField: UIView {

  private let txtBgView = UIView().then {
    $0.backgroundColor = .textFieldNormalBg
  }

  private let txtView = UIView().then {
    $0.backgroundColor = .clear
  }

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

  private func setupViews() {

    txtBgView.do {
      self.addSubview($0)
      $0.height(44)
      $0.width(46)
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

    txtField.do {
      txtView.addSubview($0)
      $0.topToSuperview(offset: 2)
      $0.bottomToSuperview(offset: -2)
      $0.leftToSuperview(offset: 2)
      $0.rightToSuperview(offset: -2)
      $0.textAlignment = .center
      $0.contentVerticalAlignment = .center
      $0.keyboardType = .decimalPad
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

    txtField.rx.text.orEmpty.changed
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: {
        print("您输入的是：\($0)")
      })
      .disposed(by: disposeBag)

    txtField.rx.text.orEmpty          // pushes text
      .map { String($0.prefix(1)) }  // pushes first X characters in text
      .distinctUntilChanged()            // only pushes if text is different than previously
      .bind(to: txtField.rx.text)   // pushes text into text field
      .disposed(by: disposeBag)
  }
}
