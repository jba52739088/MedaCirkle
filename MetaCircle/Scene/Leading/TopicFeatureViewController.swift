//
//  TopicFeatureViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/17.
//

import UIKit
import TinyConstraints
import Then
import RxSwift

class TopicFeatureViewController: BaseViewController {

  let titleContainer = UIView().then {
    $0.backgroundColor = .clear
  }

  let imgBgView = UIView().then {
    $0.backgroundColor = .normalLightBg
  }

  let imgView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  let titleLabel = UILabel()

  private lazy var collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.itemSize = CGSize(width: 157, height: 70)
    return UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
  }()
  let toolBar = UIView().then {
    $0.backgroundColor = .normalLightBg
  }
  let confirmButton = UIButton(type: .custom)

  private(set) var toolBarConstraint: Constraint?

  var viewModel: TopicFeatureViewModel

  init(_ viewModel: TopicFeatureViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    configView()
    bindViewModel()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
  }

  private func configView() {
    view.normalBackgroundGradient()

    titleContainer.do {
      view.addSubview($0)
      $0.topToSuperview(offset: 34.43, usingSafeArea: true)
      $0.centerXToSuperview()
    }

    imgBgView.do {
      titleContainer.addSubview($0)
      $0.topToSuperview()
      $0.bottomToSuperview()
      $0.leftToSuperview()
      $0.width(50)
      $0.height(50)
      $0.layer.cornerRadius = 25
      $0.layer.masksToBounds = true
    }

    imgView.do {
      imgBgView.addSubview($0)
      $0.height(37.14)
      $0.width(37.14)
      $0.centerYToSuperview()
      $0.centerXToSuperview()
      $0.layer.cornerRadius = 18.57
      $0.layer.masksToBounds = true
    }

    titleLabel.do {
      titleContainer.addSubview($0)
      $0.centerY(to: imgBgView)
      $0.leftToRight(of: imgBgView, offset: 10)
      $0.rightToSuperview()
    }

    toolBar.do {
      view.addSubview($0)
      self.toolBarConstraint = $0.height(78)
      $0.bottomToSuperview(usingSafeArea: true)
      $0.leftToSuperview()
      $0.rightToSuperview()
    }

    confirmButton.do {
      toolBar.addSubview($0)
      $0.height(44)
      $0.width(120)
      $0.layer.cornerRadius = 22
      $0.layer.masksToBounds = true
      $0.centerYToSuperview()
      $0.centerXToSuperview()
      $0.addTarget(self, action: #selector(onClickedNextButton), for: .touchUpInside)
      $0.setBackgroundImage(.withColor(.btnGray), for: .disabled)
      $0.setBackgroundImage(.withColor(.btnBlue), for: .normal)
      $0.isEnabled = false
    }

    UIView().do {
      view.addSubview($0)
      $0.backgroundColor = .normalLightBg
      $0.topToBottom(of: toolBar)
      $0.height(100)
      $0.leftToSuperview()
      $0.rightToSuperview()
    }


    collectionView.do {
      view.addSubview($0)
      $0.backgroundColor = .clear
      $0.topToBottom(of: titleContainer, offset: 33.43)
      $0.leadingToSuperview(offset: 21)
      $0.rightToSuperview(offset: -21)
      $0.bottomToTop(of: toolBar)
      $0.register(TopicFeatureItem.self, forCellWithReuseIdentifier: "Cell")
    }

    view.layoutIfNeeded()

    imgBgView.circleGradient()
  }

  private func bindViewModel() {
    titleLabel.attributedText = viewModel.titleAttributedString
    confirmButton.setAttributedTitle(viewModel.confirmAttributedString, for: .normal)
    confirmButton.setAttributedTitle(viewModel.disableConfirmAttributedString, for: .disabled)
    imgView.image = viewModel.model.image

    Observable.combineLatest(viewModel.dataRelay, viewModel.didSelectDataRelay)
      .map({ topics, selecteds -> [TopicFeatureItemViewModel] in
        return topics.map { topic in
          let isChoose = selecteds.contains(where: {$0.title == topic.title})
          return TopicFeatureItemViewModel(data: topic, isChoose: isChoose)
        }
      })
      .bind(to: collectionView.rx.items) { (collectionView, row, element) in
        let indexPath = IndexPath(row: row, section: 0)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TopicFeatureItem
        cell.viewModel = element
        return cell
      }
      .disposed(by: disposeBag)

    collectionView.rx.modelSelected(TopicFeatureItemViewModel.self)
      .subscribe(onNext: { [weak self] item in
        guard let self = self else { return }
        self.viewModel.addOrRemoveUnit(item.data)
    }).disposed(by: disposeBag)

    viewModel.didSelectDataRelay
      .asDriver(onErrorJustReturn: [])
      .drive(onNext: { [weak self] selectedDatas in
        guard let self = self else { return }
        self.confirmButton.isEnabled = !selectedDatas.isEmpty
      })
      .disposed(by: disposeBag)
  }

  @objc private func onClickedNextButton() {
    self.dismiss(animated: true)
  }
}
