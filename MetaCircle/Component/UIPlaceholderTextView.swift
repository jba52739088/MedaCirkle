//
//  UIPlaceholderTextView.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/18.
//

import UIKit
import TinyConstraints
import SwiftRichString

@IBDesignable class UIPlaceholderTextView: UITextView {
  
  var placeholderLabel: UILabel?
  
  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    sharedInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    sharedInit()
  }
  
  override func prepareForInterfaceBuilder() {
    sharedInit()
  }
  
  func sharedInit() {
    refreshPlaceholder()
    NotificationCenter.default.addObserver(self, selector: #selector(textChanged), name: UITextView.textDidChangeNotification, object: nil)
  }
  
  @IBInspectable var placeholder: String? {
    didSet {
      refreshPlaceholder()
    }
  }
  
  func refreshPlaceholder() {
    if placeholderLabel == nil {
      placeholderLabel = UILabel()
      placeholderLabel!.do {
        self.addSubview($0)
        $0.numberOfLines = 0
        $0.topToSuperview(offset: 13)
        $0.leftToSuperview(offset: 22)
        $0.rightToSuperview(offset: -22)
      }
    }
    placeholderLabel?.attributedText = placeholder?.set(style: self.textFieldPlaceholderTextStyle)
  }
  
  @objc func textChanged() {
    self.attributedText = text.set(style: self.textViewTextStyle)
    if self.placeholder?.isEmpty ?? true {
      return
    }
    
    if self.text.isEmpty {
      self.placeholderLabel?.alpha = 1.0
    } else {
      self.placeholderLabel?.alpha = 0.0
    }
  }
  
  override var text: String! {
    didSet {
      textChanged()
    }
  }
  
  
  var textFieldPlaceholderTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 17)
      $0.maximumLineHeight = 26
      $0.minimumLineHeight = 26
      $0.color = UIColor.placeholderColor
    }
  }
  
  var textViewTextStyle: StyleProtocol {
    Style {
      $0.font = R.font.notoSansTCRegular(size: 16)
      $0.maximumLineHeight = 24
      $0.minimumLineHeight = 24
      $0.color = UIColor.normalText
    }
  }
  
}
