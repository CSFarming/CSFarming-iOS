//
//  FarmingHomeViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/21/23.
//

import RIBs
import RxSwift
import UIKit
import CoreUtil
import DesignKit
import BasePresentation

protocol FarmingHomePresentableListener: AnyObject {
    func didTapClose()
    func didTap(at indexPath: IndexPath)
}

final class FarmingHomeViewController: BaseViewController, FarmingHomePresentable, FarmingHomeViewControllable {
    
    weak var listener: FarmingHomePresentableListener?
    private var models: [FarmingHomeItem] = []
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
    
    func updateTitle(_ title: String) {
        navigationView.updateTitle(title)
    }
    
    func updateModels(_ models: [FarmingHomeItem]) {
        self.models = models
        collectionView.reloadData()
    }
    
    override func setupLayout() {
        view.addSubview(navigationView)
        view.addSubview(collectionView)
        
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        view.backgroundColor = .csBlue1
        
        navigationView.setup(model: .init(leftButtonType: .back, rightButtonType: .none))
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FarmingHomeCell.self)
        collectionView.register(FarmingHomeSelectableCell.self)
        collectionView.register(FarmingHomeEmptyCell.self)
        collectionView.registerHeader(TextOnlyCollectionHeaderView.self)
    }
    
    override func bind() {
        navigationView.rx.leftButtonDidTap
            .bind(to: closeBinder)
            .disposed(by: disposeBag)
    }
    
    private func makeCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
            configuration.headerMode = .supplementary
            configuration.backgroundColor = .csBlue1
            configuration.headerTopPadding = 20
            configuration.showsSeparators = false
            let section = NSCollectionLayoutSection.list(
                using: configuration,
                layoutEnvironment: layoutEnvironment
            )
            section.contentInsets = .init(top: 20, leading: 20, bottom: 0, trailing: 20)
            section.interGroupSpacing = 10
            return section
        }
    }
    
    private var closeBinder: Binder<Void> {
        return Binder(self) { this, _ in
            this.listener?.didTapClose()
        }
    }
    
}

extension FarmingHomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        listener?.didTap(at: indexPath)
    }
    
}

extension FarmingHomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = models[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        switch item {
        case .study(let model):
            let cell = collectionView.dequeue(FarmingHomeCell.self, for: indexPath)
            cell.setup(model: model)
            return cell
            
        case .problem(let model):
            let cell = collectionView.dequeue(FarmingHomeSelectableCell.self, for: indexPath)
            cell.setup(model: model)
            return cell
            
        case .empty:
            let cell = collectionView.dequeue(FarmingHomeEmptyCell.self, for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueHeader(TextOnlyCollectionHeaderView.self, for: indexPath)
            header.updateTitle("오늘의 파밍")
            return header
            
        default:
            return UICollectionReusableView()
        }
    }
    
}
