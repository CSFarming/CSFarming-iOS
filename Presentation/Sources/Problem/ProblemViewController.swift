//
//  ProblemViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import UIKit
import DesignKit
import BasePresentation
import RIBs
import RxSwift

protocol ProblemPresentableListener: AnyObject {
    func didTap(at indexPath: IndexPath)
    func didTapCreate()
}

final class ProblemViewController: BaseViewController, ProblemPresentable, ProblemViewControllable {
    
    weak var listener: ProblemPresentableListener?
    
    private var sections: [ProblemSection] = []
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
    private let createView = ProblemCreateView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupTabBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTabBar()
    }
    
    override func setupLayout() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(createView)
        createView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
    
    override func setupAttributes() {
        view.backgroundColor = .csBlue1
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProblemContentCell.self)
        collectionView.register(LocalProblemContentCell.self)
        collectionView.registerHeader(ProblemHeader.self)
    }
    
    override func bind() {
        createView.rx.tapGesture
            .bind(to: createBinder)
            .disposed(by: disposeBag)
    }
    
    func updateSections(_ sections: [ProblemSection]) {
        self.sections = sections
        collectionView.reloadData()
    }
    
    private func makeCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
            configuration.headerMode = .supplementary
            configuration.backgroundColor = .csBlue1
            configuration.headerTopPadding = 30
            configuration.showsSeparators = false
            let section = NSCollectionLayoutSection.list(
                using: configuration,
                layoutEnvironment: layoutEnvironment
            )
            section.interGroupSpacing = 20
            section.contentInsets = .init(top: 20, leading: 20, bottom: 0, trailing: 20)
            return section
        }
    }
    
    private func setupTabBar() {
        tabBarItem = UITabBarItem(
            title: "문제",
            image: UIImage(systemName: "pencil"),
            selectedImage: UIImage(systemName: "pencil")
        )
    }
    
    private var createBinder: Binder<UITapGestureRecognizer> {
        return Binder(self) { this, _ in
            this.listener?.didTapCreate()
        }
    }
    
}

extension ProblemViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        listener?.didTap(at: indexPath)
    }
    
}

extension ProblemViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[safe: section]?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = sections[safe: indexPath.section]?.items[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        switch item {
        case .remote(let model):
            let cell = collectionView.dequeue(ProblemContentCell.self, for: indexPath)
            cell.setup(model: model)
            return cell
            
        case .local(let model):
            let cell = collectionView.dequeue(LocalProblemContentCell.self, for: indexPath)
            cell.setup(model: model)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let title = sections[safe: indexPath.section]?.header else {
                return UICollectionReusableView()
            }
            let header = collectionView.dequeueHeader(ProblemHeader.self, for: indexPath)
            header.updateTitle(title)
            return header
            
        default:
            return UICollectionReusableView()
        }
    }
    
}
