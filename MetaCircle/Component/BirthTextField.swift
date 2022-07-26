//
//  BirthTextField.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/26.
//

import UIKit
import RxSwift
import RxCocoa

class BirthTextField: UIView {

  var title: NSAttributedString? {
    didSet {
      titleLabel.attributedText = title
    }
  }

  var placeholder: NSAttributedString? {
    didSet {
      txtField.placeholder = placeholder
    }
  }

  private let titleLabel = UILabel().then {
    $0.numberOfLines = 1
  }
  private(set) var txtField = MetaTextField()
  
  private let hasTitle: Bool
  private var disposeBag = DisposeBag()
  private var birthSelectionView: BirthSelectionView?

  init(withTitle: Bool = false) {
    self.hasTitle = withTitle
    super.init(frame: .zero)
    subscribe()
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
    titleLabel.do {
      self.addSubview($0)
      $0.topToSuperview()
      $0.leftToSuperview()
      $0.height(hasTitle ? 22 : 0)
    }

    txtField.do {
      self.addSubview($0)
      $0.height(44)
      $0.topToBottom(of: titleLabel, offset: hasTitle ? 5 : 0)
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.bottomToSuperview()
      $0.layer.cornerRadius = 15
      $0.layer.masksToBounds = true
      $0.showButton = true
      $0.txtField.delegate = self
      $0.txtField.keyboardType = .numberPad
      $0.txtField.isSecureTextEntry = false
    }

    txtField.fieldButton.do {
      $0.height(20)
      $0.width(21)
      $0.rightToSuperview(offset: -17)
      $0.centerYToSuperview()
      $0.setImage(R.image.icon_calendar_1(), for: .normal)
      $0.addTarget(self, action: #selector(onClickBirthButton), for: .touchUpInside)
    }
  }

  private func subscribe() {

    txtField.txtField.rx.text.orEmpty.changed
      .asObservable()
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        if $0 == "" || $0 == "YYYY /  MM /  DD /" {
          self.txtField.txtField.text = "YYYY /  MM /  DD /"
          self.txtField.txtField.textColor = .placeholderColor
          self.txtField.txtField.setCursor(position: $0.count)
        }
      })
      .disposed(by: disposeBag)

    txtField.txtField.rx.controlEvent(.editingDidEnd)
      .asObservable()
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        if self.txtField.txtField.text == ""
            || self.txtField.txtField.text == "YYYY /  MM /  DD /" {
          self.txtField.txtField.text = ""
        }
      })
      .disposed(by: disposeBag)
  }

  @objc
  private func onClickBirthButton() {
    showSelectionView()
  }

  private func showSelectionView() {
    let popup = BirthSelectionView()
    popup.backgroundColor = .clear
    popup.bgMaskView.frame = UIScreen.main.bounds
    UIApplication.shared.keyWindow?.addSubview(popup.bgMaskView)
    popup.bgMaskView.addSubview(popup)
    popup.horizontalToSuperview()
    popup.viewBottomConstraint = popup.bottomToSuperview(offset: self.superview?.bounds.height ?? .zero)
    birthSelectionView = popup
    popup.bgMaskView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideSelectionView)))
    let swipe = UISwipeGestureRecognizer(target: self, action: #selector(hideSelectionView))
    swipe.direction = .down
    popup.addGestureRecognizer(swipe)
    popup.setPopUpWithAnimation(isHidden: false, complete: { [weak self] _ in
      guard let self = self else { return }

    })
  }

  @objc
  private func hideSelectionView() {
    guard let popup = birthSelectionView else { return }
    popup.setPopUpWithAnimation(isHidden: true, complete: {[weak self] completed in
      guard completed, let self = self else { return }
      self.birthSelectionView?.removeFromSuperview()
      self.birthSelectionView = nil
    })
  }
}

extension BirthTextField: UITextFieldDelegate {

  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

    guard var number = textField.text else {
      return true
    }
    // If user try to delete, remove the char manually
    if string == "" {
      number.remove(at: number.index(number.startIndex, offsetBy: range.location))
    }
    // Remove all mask characters
    number = number.replacingOccurrences(of: " ", with: "")
    number = number.replacingOccurrences(of: "/", with: "")
    number = number.replacingOccurrences(of: "D", with: "")
    number = number.replacingOccurrences(of: "M", with: "")
    number = number.replacingOccurrences(of: "Y", with: "")

    // Set the position of the cursor
    var cursorPosition = number.count+1
    if string == "" {
      //if it's delete, just take the position given by the delegate
      cursorPosition = range.location
    } else {
      // If not, take into account the slash
      if cursorPosition > 3 && cursorPosition < 6 {
        /// MM
        cursorPosition += 4
      } else if cursorPosition > 5 {
        /// DD
        cursorPosition += 8
      }
    }
    // Stop editing if we have rich the max numbers
    if number.count == 8 { return false }
    // Readd all mask char
    number += string
    while number.count < 8 {
      if number.count < 4 {
        number += "Y"
      } else if number.count < 6 {
        number += "M"
      } else {
        number += "D"
      }
    }
    number.insert(contentsOf: " /", at: number.index(number.startIndex, offsetBy: 8))
    number.insert(contentsOf: " /  ", at: number.index(number.startIndex, offsetBy: 6))
    number.insert(contentsOf: " /  ", at: number.index(number.startIndex, offsetBy: 4))

    // Some styling
    let enteredTextAttribute = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                NSAttributedString.Key.font: R.font.promptRegular(size: 17)]
    let maskTextAttribute = [NSAttributedString.Key.foregroundColor: UIColor.placeholderColor,
                             NSAttributedString.Key.font: R.font.promptRegular(size: 17)]

    let combination = NSMutableAttributedString()

    if cursorPosition < 8 {
      let partYear = NSMutableAttributedString(string: String(number.prefix(cursorPosition)),
                                              attributes: enteredTextAttribute as [NSAttributedString.Key : Any])
      let partMask = NSMutableAttributedString(string: String(number.suffix(number.count - cursorPosition)),
                                              attributes: maskTextAttribute as [NSAttributedString.Key : Any])
      combination.append(partYear)
      combination.append(partMask)
    } else if cursorPosition < 14 {
      let partYear = NSMutableAttributedString(string: String(number.prefix(4)),
                                              attributes: enteredTextAttribute as [NSAttributedString.Key : Any])
      let partMask1 = NSMutableAttributedString(string: number.subString(from: 4, to: 8),
                                              attributes: maskTextAttribute as [NSAttributedString.Key : Any])
      let partMonth = NSMutableAttributedString(string: number.subString(from: 8, to: cursorPosition),
                                              attributes: enteredTextAttribute as [NSAttributedString.Key : Any])
      let partMask2 = NSMutableAttributedString(string: String(number.suffix(number.count - cursorPosition)),
                                              attributes: maskTextAttribute as [NSAttributedString.Key : Any])
      combination.append(partYear)
      combination.append(partMask1)
      combination.append(partMonth)
      combination.append(partMask2)
    } else if cursorPosition < number.count {
      let partYear = NSMutableAttributedString(string: String(number.prefix(4)),
                                              attributes: enteredTextAttribute as [NSAttributedString.Key : Any])
      let partMask1 = NSMutableAttributedString(string: number.subString(from: 4, to: 8),
                                              attributes: maskTextAttribute as [NSAttributedString.Key : Any])
      let partMonth = NSMutableAttributedString(string: number.subString(from: 8, to: 10),
                                              attributes: enteredTextAttribute as [NSAttributedString.Key : Any])
      let partMask2 = NSMutableAttributedString(string: number.subString(from: 10, to: 14),
                                              attributes: maskTextAttribute as [NSAttributedString.Key : Any])
      let partDate = NSMutableAttributedString(string: number.subString(from: 14, to: cursorPosition),
                                              attributes: enteredTextAttribute as [NSAttributedString.Key : Any])
      let partMask3 = NSMutableAttributedString(string: String(number.suffix(number.count - cursorPosition)),
                                              attributes: maskTextAttribute as [NSAttributedString.Key : Any])
      combination.append(partYear)
      combination.append(partMask1)
      combination.append(partMonth)
      combination.append(partMask2)
      combination.append(partDate)
      combination.append(partMask3)
    }

    textField.attributedText = combination
    textField.setCursor(position: cursorPosition)


    return false
  }
}

extension UITextField {
    func setCursor(position: Int) {
        let position = self.position(from: beginningOfDocument, offset: position)!
        selectedTextRange = textRange(from: position, to: position)
    }
}
