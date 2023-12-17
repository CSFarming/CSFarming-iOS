//
//  QuestionCompleteViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/15/23.
//

import RIBs
import RxSwift
import UIKit
import DesignKit
import BasePresentation

protocol QuestionCompletePresentableListener: AnyObject {
    func didTap(at indexPath: IndexPath)
    func didTapDone()
}

final class QuestionCompleteViewController: BaseViewController, QuestionCompletePresentable, QuestionCompleteViewControllable {
    
    weak var listener: QuestionCompletePresentableListener?
    
    private var sections: [QuestionCompleteSection] = []
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
    private let doneButton = ActionButton()
    
    func updateTitle(_ title: String) {
        navigationView.updateTitle(title)
    }
    
    func updateSections(_ sections: [QuestionCompleteSection]) {
        self.sections = sections
        collectionView.reloadData()
    }
    
    func updateModel(at indexPath: IndexPath, model: QuestionCompleteCellModel) {
        sections = sections.updating(at: indexPath, model: model)
        collectionView.reloadItems(at: [indexPath])
    }
    
    override func bind() {
        doneButton.rx.tap
            .bind(to: doneBinder)
            .disposed(by: disposeBag)
    }
    
    override func setupLayout() {
        view.addSubview(navigationView)
        view.addSubview(doneButton)
        view.addSubview(collectionView)
        
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        doneButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(doneButton.snp.top)
        }
    }
    
    override func setupAttributes() {
        isSwipeBackEnabled = false
        
        view.backgroundColor = .csBlue1
        navigationView.setup(model: .init(leftButtonType: .none, rightButtonType: .none))
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(QuestionCompleteCell.self)
        collectionView.registerHeader(QuestionCompleteHeader.self)
        
        doneButton.style = .normal
        doneButton.setTitle("완료", for: .normal)
        doneButton.layer.cornerRadius = 16
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
            section.interGroupSpacing = 10
            section.contentInsets = .init(top: 20, leading: 20, bottom: 0, trailing: 20)
            return section
        }
    }
    
    private var doneBinder: Binder<Void> {
        return Binder(self) { this, _ in
            this.listener?.didTapDone()
        }
    }
    
}

extension QuestionCompleteViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        listener?.didTap(at: indexPath)
    }
    
}

extension QuestionCompleteViewController: UICollectionViewDataSource {
    
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
        let cell = collectionView.dequeue(QuestionCompleteCell.self, for: indexPath)
        cell.setup(model: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let title = sections[safe: indexPath.section]?.title else {
                return UICollectionReusableView()
            }
            let header = collectionView.dequeueHeader(QuestionCompleteHeader.self, for: indexPath)
            header.updateTitle(title)
            return header
            
        default:
            return UICollectionReusableView()
        }
    }
    
}
