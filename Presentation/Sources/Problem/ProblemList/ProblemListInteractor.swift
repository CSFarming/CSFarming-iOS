//
//  ProblemListInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/9/23.
//

import Foundation
import RIBs
import RxSwift
import ProblemInterface
import ProblemService

protocol ProblemListRouting: ViewableRouting {}

protocol ProblemListPresentable: Presentable {
    var listener: ProblemListPresentableListener? { get set }
    func updateTitle(_ title: String)
    func updateModels(_ models: [ProblemListCellModel])
}

protocol ProblemListListener: AnyObject {
    func problemListDidTapClose()
}

protocol ProblemListInteractorDependency: AnyObject {
    var title: String { get }
    var directory: String { get }
    var problemService: ProblemServiceInterface { get }
}

final class ProblemListInteractor: PresentableInteractor<ProblemListPresentable>, ProblemListInteractable, ProblemListPresentableListener {
    
    weak var router: ProblemListRouting?
    weak var listener: ProblemListListener?
    
    private var elements: [ProblemElement] = []
    private let dependency: ProblemListInteractorDependency
    private let disposeBag = DisposeBag()
    
    init(presenter: ProblemListPresentable, dependency: ProblemListInteractorDependency) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.updateTitle(dependency.title)
        fetchProblemList()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapClose() {
        listener?.problemListDidTapClose()
    }
    
    func didTap(at indexPath: IndexPath) {
        guard let element = elements[safe: indexPath.row] else { return }
    }
    
    private func fetchProblemList() {
        dependency.problemService
            .requestElements(directory: dependency.directory)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                with: self,
                onSuccess: { this, elements in
                    this.performAfterFetchingList(elements)
                },
                onFailure: { this, error in
                    print(error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func performAfterFetchingList(_ elements: [ProblemElement]) {
        self.elements = elements
        let models = elements.map { $0.toModel() }
        presenter.updateModels(models)
    }
    
}

private extension ProblemElement {
    
    func toModel() -> ProblemListCellModel {
        let type: ProblemListCellType = {
            switch self.type {
            case .list: return .folder
            case .question: return .file
            }
        }()
        return .init(title: title, content: content, type: type)
    }
    
}
