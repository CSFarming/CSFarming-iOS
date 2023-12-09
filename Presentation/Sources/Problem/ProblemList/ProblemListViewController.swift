//
//  ProblemListViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/9/23.
//

import UIKit
import RIBs
import RxSwift
import RxCocoa
import SnapKit
import DesignKit
import CoreUtil
import BasePresentation

protocol ProblemListPresentableListener: AnyObject {
    func didTapClose()
    func didTap(at indexPath: IndexPath)
}

final class ProblemListViewController: BaseViewController, ProblemListPresentable, ProblemListViewControllable {
    
    weak var listener: ProblemListPresentableListener?
    
    private var models: [ProblemListCellModel] = []
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
    
    func updateModels(_ models: [ProblemListCellModel]) {
        self.models = models
        collectionView.reloadData()
    }
    
    func updateTitle(_ title: String) {
        navigationView.updateTitle(title)
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
        collectionView.register(ProblemListCell.self)
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
            section.contentInsets = .zero
            return section
        }
    }
    
    private var closeBinder: Binder<Void> {
        return Binder(self) { this, _ in
            this.listener?.didTapClose()
        }
    }
    
}

extension ProblemListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        listener?.didTap(at: indexPath)
    }
    
}

extension ProblemListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = models[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeue(ProblemListCell.self, for: indexPath)
        cell.setup(model: model)
        return cell
    }
    
}
