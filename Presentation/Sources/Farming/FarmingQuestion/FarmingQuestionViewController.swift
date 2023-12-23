//
//  FarmingQuestionViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/23/23.
//

import RIBs
import RxSwift
import UIKit
import SnapKit
import DesignKit
import BasePresentation

protocol FarmingQuestionPresentableListener: AnyObject {
    func didTapClose()
    func didTap(at indexPath: IndexPath)
}

final class FarmingQuestionViewController: BaseViewController, FarmingQuestionPresentable, FarmingQuestionViewControllable {
    
    weak var listener: FarmingQuestionPresentableListener?
    
    private var sections: [FarmingQuestionSection] = []
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
    
    func updateTitle(_ title: String) {
        navigationView.updateTitle(title)
    }
    
    func updateSections(_ sections: [FarmingQuestionSection]) {
        self.sections = sections
        collectionView.reloadData()
    }
    
    func updateModel(at indexPath: IndexPath, model: FarmingQuestionCellModel) {
        sections = sections.updating(at: indexPath, model: model)
        collectionView.reloadItems(at: [indexPath])
    }
    
    override func setupLayout() {
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        view.addSubview(collectionView)
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
        collectionView.register(FarmingQuestionCell.self)
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
            configuration.headerTopPadding = 40
            configuration.showsSeparators = false
            let section = NSCollectionLayoutSection.list(
                using: configuration,
                layoutEnvironment: layoutEnvironment
            )
            section.interGroupSpacing = 10
            section.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
            return section
        }
    }
    
    private var closeBinder: Binder<Void> {
        return Binder(self) { this, _ in
            this.listener?.didTapClose()
        }
    }
    
}

extension FarmingQuestionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        listener?.didTap(at: indexPath)
    }
    
}

extension FarmingQuestionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[safe: section]?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = sections[safe: indexPath.section],
              let model = section.items[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeue(FarmingQuestionCell.self, for: indexPath)
        cell.setup(model: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let title = sections[safe: indexPath.section]?.title else {
                return UICollectionReusableView()
            }
            let header = collectionView.dequeueHeader(TextOnlyCollectionHeaderView.self, for: indexPath)
            header.updateTitle(title)
            return header
            
        default:
            return UICollectionReusableView()
        }
    }
    
}
