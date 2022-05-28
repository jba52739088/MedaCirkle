//
//  BirthSelectionView.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/26.
//

import TinyConstraints
import RxSwift
import UIKit
import SwiftRichString

class BirthSelectionView: UIView {
  let disposeBag = DisposeBag()
  var popupTopConstraint: Constraint?
  var viewBottomConstraint: Constraint?
  let popUpContainer = UIView()
  let titleLabel = UILabel().then { $0.numberOfLines = 0 }
  let bgMaskView: UIView = UIView().then {
    $0.backgroundColor = .black.withAlphaComponent(0.5)
  }

  required init() {
    super.init(frame: .zero)
    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setPopUpWithAnimation(isHidden: Bool, complete: ((Bool) -> Void)? = nil) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      UIView.animate(
        withDuration: 0.6,
        delay: 0,
        options: [.allowAnimatedContent, .curveEaseOut],
        animations: ({ [weak self] in
          guard let self = self else { return }
          self.viewBottomConstraint?.constant = isHidden ? (self.superview?.bounds.height ?? 0) : 0
          self.superview?.setNeedsLayout()
          self.superview?.layoutIfNeeded()
        }), completion: { [weak self] _ in
//          self?.popUpContainer.roundCorners(corners: [.topRight, .topLeft], radius: 8)
          if isHidden {
            self?.bgMaskView.removeFromSuperview()
          }
          complete?(true)
      })
    }
  }

  private func setupViews() {

    var titleTextStyle: StyleProtocol {
      Style {
        $0.font = R.font.promptMedium(size: 17)
        $0.maximumLineHeight = 26
        $0.minimumLineHeight = 26
        $0.color = UIColor.black
      }
    }

    popUpContainer.do {
      addSubview($0)
      $0.backgroundColor = .white
      $0.edgesToSuperview(excluding: .top)
      popupTopConstraint = popUpContainer.topToSuperview()
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.height(350)
    }

    UIView().do {
      popUpContainer.addSubview($0)
      $0.backgroundColor = "#B4B4B4".color
      $0.width(32)
      $0.height(6)
      $0.topToSuperview(offset: 13)
      $0.centerXToSuperview()
      $0.layer.cornerRadius = 3
      $0.layer.masksToBounds = true
      
    }

    titleLabel.do {
      popUpContainer.addSubview($0)
      $0.attributedText = R.string.localizable.verify_vc_birth_selection().set(style: titleTextStyle)
      $0.topToSuperview(offset: 43)
      $0.centerXToSuperview()
      $0.textAlignment = .center
    }

    UIDatePicker().do {
      if #available(iOS 13.4, *) {
        $0.preferredDatePickerStyle = .wheels
      }
      popUpContainer.addSubview($0)
      $0.timeZone = NSTimeZone.local
      $0.datePickerMode = .date
      $0.backgroundColor = .clear
      $0.topToBottom(of: titleLabel, offset: 18)
      $0.leftToSuperview(offset: 38)
      $0.rightToSuperview(offset: -38)
      $0.bottomToSuperview(offset: -50)
      $0.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
    }
  }
  
  @objc
  private func datePickerValueChanged(_ sender: UIDatePicker){

    let dateFormatter: DateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    let selectedDate: String = dateFormatter.string(from: sender.date)

    print("Selected value \(selectedDate)")
  }
}
