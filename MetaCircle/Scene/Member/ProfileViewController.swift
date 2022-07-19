//
//  ProfileViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/7/12.
//

import UIKit
import TinyConstraints
import RxSwift
import RxCocoa

class ProfileViewController: BaseViewController {

  private lazy var backButton: UIButton = .backButton(target: self, action: #selector(didTapBackButton))
  let tableView = UITableView()

  let viewModel: ProfileViewModel

  init(_ viewModel: ProfileViewModel) {
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
    if !MainAppService.shared.isLogin {
      sceneCoordinator.transit(to: .login, by: .overFullScreen, completion: nil)
      return
    }
    configView()
    bindViewModel()
  }

  private func configView() {
    self.isGradientBackground = true

    tableView.do {
      $0.contentInsetAdjustmentBehavior = .never
      view.addSubview($0)
      $0.backgroundColor = .clear
      $0.showsVerticalScrollIndicator = false
      $0.bounces = false
      $0.topToSuperview()
      $0.leadingToSuperview()
      $0.rightToSuperview()
      $0.bottomToSuperview()
      $0.separatorColor = .clear
      $0.register(ProfileHeaderCell.self, forCellReuseIdentifier: "HeaderCell")
      $0.register(ProfileItemCell.self, forCellReuseIdentifier: "Cell")
      $0.layer.masksToBounds = true
    }

    backButton.do {
      view.addSubview($0)
      $0.topToSuperview(offset: 10, usingSafeArea: true)
      $0.leadingToSuperview(offset: 10)
      $0.height(30)
      $0.width(30)
      $0.backgroundColor = UIColor.white.withAlphaComponent(0.8)
      $0.layer.cornerRadius = 15
      $0.layer.masksToBounds = true
    }
  }

  private func bindViewModel() {

    viewModel.itemsRelay
      .bind(to: tableView.rx.items) { (tableView, row, element) in
        switch element.type {
        case .header:
          if let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as? ProfileHeaderCell,
             let vm = element as? ProfileHeaderCellViewModel {
            cell.viewModel = vm
            return cell
          }
        default:
          if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ProfileItemCell,
             let vm = element as? ProfileItemCellViewModel {
            cell.viewModel = vm
            return cell
          }
        }
        return UITableViewCell()
      }
      .disposed(by: disposeBag)

    Observable
      .zip(tableView.rx.itemSelected, tableView.rx.modelSelected(ProfileCellViewModel.self))
      .bind { [unowned self] indexPath, vm in

        print("Selected " + vm.type.title + " at \(indexPath)")
        sceneCoordinator.transit(to: vm.type.scene, by: .present(transitionStyle: .coverVertical, animated: true), completion: nil)
      }
      .disposed(by: disposeBag)
  }

  @objc
  private func didTapBackButton() {
    print("didTapBackButton")
    sceneCoordinator.dismiss(animated: true, completion: nil)
  }
}

