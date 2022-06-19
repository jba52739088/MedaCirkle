//
//  CircleContentViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/29.
//

import UIKit
import TinyConstraints
import RxSwift
import RxCocoa

class CircleContentViewController: BaseViewController {

  var shortTopHeightConstraint: Constraint?

  let shortTopView = UIView()
  let tableView = UITableView()

  let viewModel: CircleContentViewModel

  init(_ viewModel: CircleContentViewModel) {
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
    view.normalBackgroundGradient()

    shortTopView.do {
      view.addSubview($0)
      $0.backgroundColor = .normalLightBg
      $0.rightToSuperview()
      $0.leftToSuperview()
      $0.topToSuperview()
      self.shortTopHeightConstraint = $0.height(50)
    }

    tableView.do {
      view.addSubview($0)
      $0.backgroundColor = .clear
      $0.topToBottom(of: shortTopView, offset: 0)
      $0.leadingToSuperview()
      $0.rightToSuperview()
      $0.bottomToSuperview()
      $0.separatorColor = .clear
      $0.register(CircleContentTopCell.self, forCellReuseIdentifier: "topCell")
      $0.register(CircleContentCategoryCell.self, forCellReuseIdentifier: "categoryCell")
      $0.register(CircleContentPinCell.self, forCellReuseIdentifier: "pinCell")
      $0.register(CircleContentCell.self, forCellReuseIdentifier: "cell")
    }
  }

  private func bindViewModel() {
    viewModel.cellVMsRelay
//      .map { $0.compactMap { CircleContentTopCellViewModel(data: $0) }}
      .bind(to: tableView.rx.items) { (tableView, row, element) in
        switch element.type {
        case .top:
          if let cell = tableView.dequeueReusableCell(withIdentifier: "topCell") as? CircleContentTopCell {
            cell.viewModel = element
            cell.delegate = self
            return cell
          }
        case .category:
          if let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as? CircleContentCategoryCell {
            cell.viewModel = element
            return cell
          }
        case .pin:
          if let cell = tableView.dequeueReusableCell(withIdentifier: "pinCell") as? CircleContentPinCell {
            cell.viewModel = element
            return cell
          }
        default:
          if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CircleContentCell {
            cell.viewModel = element
            cell.delegate = self
            return cell
          }
        }
        return UITableViewCell()
      }
      .disposed(by: disposeBag)

//    tableView
//      .rx.setDelegate(self)
//      .disposed(by: disposeBag)
  }
}

extension CircleContentViewController: CircleContentTopCellDelegate {
    func didClickBackButton(in view: CircleContentTopCell) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: CircleContentCellDelegate

extension CircleContentViewController: CircleContentCellDelegate {
    func didClickReadMore(in view: CircleContentCell) {
//        sceneCoordinator.transit(to: .circle(CircleViewModel()), by: .present(transitionStyle: .coverVertical, animated: true), completion: nil)
//        self.navigationController?.pushViewController(Scene.circle(CircleViewModel()).viewController(), animated: true)
        
        sceneCoordinator.transit(to: .circle(CircleViewModel(data: tempCircleModel)), by: .overFullScreen, completion: nil)
    }
    
    func didClickAwesome(in view: CircleContentCell) {
        
    }
    
    func didClickMenu(in view: CircleContentCell) {
        
    }
    
    func didClickBookmark(in view: CircleContentCell) {
        
    }
    
    func didClickShare(in view: CircleContentCell) {
        
    }
    
    func didClickReply(in view: CircleContentCell) {
        
    }
    
  
}
