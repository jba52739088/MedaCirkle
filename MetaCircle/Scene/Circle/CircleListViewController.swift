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

class CircleListViewController: BaseViewController {

  let joinedLabel = UILabel()
  let sortButton = UIButton(type: .custom)
  let tableView = UITableView()

  let viewModel: CircleListViewModel

  init(_ viewModel: CircleListViewModel) {
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
    view.backgroundColor = .clear

    joinedLabel.do {
      view.addSubview($0)
      $0.leadingToSuperview(offset: 18)
      $0.topToSuperview(offset: 16)
    }

    sortButton.do {
      view.addSubview($0)
      $0.rightToSuperview(offset: -15, usingSafeArea: true)
      $0.centerY(to: joinedLabel)
      $0.setImage(R.image.icon_down_01(), for: .normal)
      $0.semanticContentAttribute = .forceRightToLeft
      $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 2.5, bottom: 0, right: -2.5)
      $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: -2.5, bottom: 0, right: 2.5)
      $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 2.5, bottom: 0, right: 2.5)
    }

    tableView.do {
      view.addSubview($0)
      $0.backgroundColor = .clear
      $0.topToBottom(of: joinedLabel, offset: 15)
      $0.leadingToSuperview(offset: 17.5)
      $0.rightToSuperview(offset: -17.5)
      $0.bottomToSuperview()
      $0.separatorColor = .clear
      $0.register(CircleCell.self, forCellReuseIdentifier: "Cell")
    }
  }

  private func bindViewModel() {
    joinedLabel.attributedText = viewModel.joinedCountAttributedString
    sortButton.setAttributedTitle(viewModel.sortLabelAttributedString, for: .normal)

    sortButton.rx.tap
      .subscribe(onNext: { [weak self] in
        guard let self = self,
        let btnImgView = self.sortButton.imageView
        else { return }
        btnImgView.transform = btnImgView.transform.rotated(by: .pi)
      })
      .disposed(by: disposeBag)

    viewModel.dataRelay
      .map { $0.compactMap { CircleCellViewModel(data: $0) }}
      .bind(to: tableView.rx.items) { (tableView, row, element) in
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CircleCell
        cell.viewModel = element
        return cell
      }
      .disposed(by: disposeBag)

    Observable
      .zip(tableView.rx.itemSelected, tableView.rx.modelSelected(CircleCellViewModel.self))
      .bind { [unowned self] indexPath, model in
//        self.tableView.deselectRow(at: indexPath, animated: true)
        print("Selected " + model.data.title + " at \(indexPath)")
//        sceneCoordinator.transit(to: .circleContent(CircleContentViewModel(type: .Created)), by: .automatic, completion: nil)
        self.navigationController?.pushViewController(Scene.circleContent(CircleContentViewModel(data: model.data)).viewController(), animated: true)
      }
      .disposed(by: disposeBag)
//    tableView
//      .rx.setDelegate(self)
//      .disposed(by: disposeBag)
  }
}

//extension CircleListViewController: UITableViewDelegate {
//  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    return 88
//  }
//}
