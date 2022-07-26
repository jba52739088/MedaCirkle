//
//  EditSocialMediaViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/20.
//

import UIKit
import TinyConstraints
import RxSwift
import RxCocoa

class EditSocialMediaViewController: BaseViewController {

  private let topView = UIView().then {
    $0.backgroundColor = .clear
  }
  private lazy var backButton: UIButton = .closeButton(target: self, action: #selector(didTapCloseButton))
  private let titleLabel = UILabel()
  let tableView = UITableView()

  let viewModel: EditSocialMediaViewModel

  init(_ viewModel: EditSocialMediaViewModel = EditSocialMediaViewModel()) {
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

    configView()
    bindViewModel()
  }

  private func configView() {
    view.backgroundColor = .normalLightBg
    topView.do {
      view.addSubview($0)
      $0.height(50)
      $0.topToSuperview(usingSafeArea: true)
      $0.leftToSuperview()
      $0.rightToSuperview()
    }

    backButton.do {
      topView.addSubview($0)
      $0.width(30)
      $0.height(30)
      $0.rightToSuperview(offset: -10, usingSafeArea: true)
      $0.centerYToSuperview()
    }

    titleLabel.do {
      topView.addSubview($0)
      $0.centerYToSuperview()
      $0.centerXToSuperview()
    }

    tableView.do {
      $0.contentInsetAdjustmentBehavior = .never
      view.addSubview($0)
      $0.backgroundColor = .clear
      $0.showsVerticalScrollIndicator = false
      $0.bounces = false
      $0.topToBottom(of: topView, offset: 30)
      $0.leadingToSuperview()
      $0.rightToSuperview()
      $0.bottomToSuperview(offset: -5, usingSafeArea: true)
      $0.separatorColor = .clear
      $0.register(EditSocialMediaCell.self, forCellReuseIdentifier: "Cell")
      $0.layer.masksToBounds = true
    }
  }


  private func bindViewModel() {
    titleLabel.attributedText = viewModel.titleAttributedString

    viewModel.itemsRelay
      .bind(to: tableView.rx.items) { (tableView, row, element) in

        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? EditSocialMediaCell {
          cell.viewModel = element
          return cell
        }
        return UITableViewCell()
      }
      .disposed(by: disposeBag)
  }

  @objc
  private func didTapCloseButton() {
    sceneCoordinator.dismiss(animated: true, completion: nil)
  }

}

