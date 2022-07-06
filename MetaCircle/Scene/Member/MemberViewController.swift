//
//  MemberViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/15.
//

import UIKit
import TinyConstraints
import RxSwift
import RxCocoa

class MemberViewController: BaseViewController {

  let navView = UIView().then {
    $0.backgroundColor = .normalLightBg
  }
  let mainContain = UIView()
  let logoImgView = UIImageView() .then {
    $0.image = R.image.logo_2()
    $0.contentMode = .scaleAspectFit
  }
  let searchBtn: UIButton = UIView.searchBarButton()
  let bellBtn: UIButton = UIView.bellButton()
  let tableView = UITableView()

  let viewModel: MemberViewModel

  init(_ viewModel: MemberViewModel) {
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

    view.backgroundColor = .normalLightBg

    navView.do {
      view.addSubview($0)
      $0.backgroundColor = .normalLightBg
      $0.topToSuperview(usingSafeArea: true)
      $0.height(50)
      $0.leadingToSuperview(offset: 0)
      $0.trailingToSuperview(offset: 0)
    }

    mainContain.do {
      view.addSubview($0)
      $0.backgroundColor = .normalLightBg
      $0.topToBottom(of: navView)
      $0.leadingToSuperview()
      $0.trailingToSuperview()
      $0.bottomToSuperview()
    }

    logoImgView.do {
      navView.addSubview($0)
      $0.width(126.2)
      $0.height(18.35)
      $0.topToSuperview(offset: 16, usingSafeArea: true)
      $0.leadingToSuperview(offset: 15)
    }

    bellBtn.do {
      navView.addSubview($0)
      $0.width(26)
      $0.height(26)
      $0.centerY(to: logoImgView)
      $0.rightToSuperview(offset: -15)
    }

    searchBtn.do {
      navView.addSubview($0)
      $0.width(26)
      $0.height(26)
      $0.centerY(to: logoImgView)
      $0.rightToLeft(of: bellBtn, offset: -17)
    }

    tableView.do {
      mainContain.addSubview($0)
      $0.backgroundColor = .clear
      $0.showsVerticalScrollIndicator = false
      $0.bounces = false
      $0.topToSuperview()
      $0.leadingToSuperview(offset: 24)
      $0.rightToSuperview(offset: -24)
      $0.bottomToSuperview()
      $0.separatorColor = .clear
      $0.register(MemberProfileCell.self, forCellReuseIdentifier: "ProfileCell")
      $0.register(MemberInfoCell.self, forCellReuseIdentifier: "InfoCell")
      $0.register(MemberListItemCell.self, forCellReuseIdentifier: "Cell")
      $0.layer.masksToBounds = true
    }
  }

  private func bindViewModel() {

    viewModel.itemsRelay
      .bind(to: tableView.rx.items) { (tableView, row, element) in
        switch element.type {
        case .profile:
          if let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as? MemberProfileCell,
             let vm = element as? MemberProfileCellViewModel {
            cell.viewModel = vm
            return cell
          }
        case .info:
          if let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") as? MemberInfoCell,
             let vm = element as? MemberInfoCellViewModel {
            cell.viewModel = vm
            return cell
          }
        default:
          if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? MemberListItemCell,
             let vm = element as? MemberListItemCellViewModel {
            cell.viewModel = vm
            return cell
          }
        }
        return UITableViewCell()
      }
      .disposed(by: disposeBag)
  }
}
