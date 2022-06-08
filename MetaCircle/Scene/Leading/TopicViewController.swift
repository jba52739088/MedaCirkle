//
//  TopicViewController.swift
//  MetaCircle
//
//  Created by 黃恩祐 on 2022/5/17.
//

import UIKit
import TinyConstraints
import Then
import RxSwift

class TopicViewController: BaseViewController {

  let tipLabel = UILabel()
  let titleLabel = UILabel()
  let subtitleLabel = UILabel().then {
    $0.numberOfLines = 0
  }
  private lazy var collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.itemSize = CGSize(width: 96, height: 101)
    return UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
  }()
  let toolBar = UIView().then {
    $0.backgroundColor = .normalLightBg
  }
  let didSelectLabel = UILabel()
  let nextButton = UIButton(type: .custom)

  private(set) var toolBarConstraint: Constraint?

  var viewModel: TopicViewModel

  init(_ viewModel: TopicViewModel = TopicViewModel()) {
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
    view.backgroundColor = .normalLightBg

    tipLabel.do {
      view.addSubview($0)
      $0.topToSuperview(offset: 13, usingSafeArea: true)
      $0.rightToSuperview(offset: -27)
    }

    titleLabel.do {
      view.addSubview($0)
      $0.topToSuperview(offset: 58, usingSafeArea: true)
      $0.leftToSuperview(offset: 23)
    }

    subtitleLabel.do {
      view.addSubview($0)
      $0.topToBottom(of: titleLabel, offset: 7)
      $0.leftToSuperview(offset: 23)
    }

    toolBar.do {
      view.addSubview($0)
      self.toolBarConstraint = $0.height(78)
      $0.bottomToSuperview(usingSafeArea: true)
      $0.leftToSuperview()
      $0.rightToSuperview()
      $0.layer.shadowOffset = CGSize(width: 0, height: -3)
      $0.layer.shadowRadius = 3
      $0.layer.shadowColor = UIColor.black.cgColor
      $0.layer.shadowOpacity = 0.08
    }

    nextButton.do {
      toolBar.addSubview($0)
      $0.height(44)
      $0.width(120)
      $0.layer.cornerRadius = 22
      $0.layer.masksToBounds = true
      $0.topToSuperview(offset: 17)
      $0.rightToSuperview(offset: -24)
      $0.addTarget(self, action: #selector(onClickedNextButton), for: .touchUpInside)
      $0.setBackgroundImage(.withColor(.btnGray), for: .disabled)
      $0.setBackgroundImage(.withColor(.btnBlue), for: .normal)
      $0.isEnabled = false
    }

    didSelectLabel.do {
      toolBar.addSubview($0)
      $0.centerY(to: nextButton)
      $0.leftToSuperview(offset: 24)
    }

    collectionView.do {
      view.addSubview($0)
      $0.backgroundColor = .clear
      $0.topToBottom(of: subtitleLabel, offset: 30)
      $0.leadingToSuperview(offset: 23)
      $0.rightToSuperview(offset: -23)
      $0.bottomToTop(of: toolBar)
      $0.register(TopicItem.self, forCellWithReuseIdentifier: "Cell")
    }

    view.bringSubviewToFront(toolBar)
  }

  private func bindViewModel() {
    tipLabel.attributedText = viewModel.countHintAttributedString
    titleLabel.attributedText = viewModel.titleAttributedString
    subtitleLabel.attributedText = viewModel.subtitleAttributedString
    nextButton.setAttributedTitle(viewModel.nextAttributedString, for: .normal)
    nextButton.setAttributedTitle(viewModel.disableNextAttributedString, for: .disabled)
    didSelectLabel.attributedText = viewModel.didSelectAttributedString(0)

    Observable.combineLatest(viewModel.dataRelay, viewModel.didSelectDataRelay)
      .map({ topics, selecteds -> [TopicItemViewModel] in
        return topics.map { topic in
          let isChoose = selecteds.contains(where: {$0.title == topic.title})
          return TopicItemViewModel(data: topic, isChoose: isChoose)
        }
      })
      .bind(to: collectionView.rx.items) { (collectionView, row, element) in
        let indexPath = IndexPath(row: row, section: 0)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TopicItem
        cell.viewModel = element
        return cell
      }
      .disposed(by: disposeBag)

    collectionView.rx.modelSelected(TopicItemViewModel.self)
      .subscribe(onNext: { [weak self] item in
        guard let self = self else { return }
        self.viewModel.addOrRemoveUnit(item.data)
        sceneCoordinator.transit(to: .chooseTopicFeature(TopicFeatureViewModel(model: item.data)), by: .overFullScreen, completion: nil)
    }).disposed(by: disposeBag)

    viewModel.didSelectDataRelay
      .asDriver(onErrorJustReturn: [])
      .drive(onNext: { [weak self] selectedDatas in
        guard let self = self else { return }
        self.toolBarConstraint?.constant = selectedDatas.isEmpty ? 0 : 78
        self.toolBar.isHidden = selectedDatas.isEmpty
        self.didSelectLabel.attributedText = self.viewModel.didSelectAttributedString(selectedDatas.count)
        self.nextButton.isEnabled = selectedDatas.count >= 3
      })
      .disposed(by: disposeBag)
  }

  @objc private func onClickedNextButton() {
    self.dismiss(animated: true)
//    IntroViewController.dismissIntroRelay.accept(true)
    sceneCoordinator.transit(to: .home, by: .root, completion: nil)
  }
}
