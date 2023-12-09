//
//  ProblemInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import RIBs
import RxSwift
import ProblemInterface
import ProblemService

protocol ProblemRouting: ViewableRouting {
    func attachQuestion(title: String, directory: String)
    func detachQuestion()
}

protocol ProblemPresentable: Presentable {
    var listener: ProblemPresentableListener? { get set }
    func updateModels(_ models: [ProblemContentViewModel])
}

protocol ProblemInteractorDependency: AnyObject {
    var problemService: ProblemServiceInterface { get }
}

final class ProblemInteractor: PresentableInteractor<ProblemPresentable>, ProblemInteractable, ProblemPresentableListener {
    
    weak var router: ProblemRouting?
    weak var listener: ProblemListener?
    
    private var elements: [ProblemElement] = []
    
    private let dependency: ProblemInteractorDependency
    private let disposeBag = DisposeBag()
    
    init(
        presenter: ProblemPresentable,
        dependency: ProblemInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        fetchProblemList()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTap(model: ProblemContentViewModel) {
        router?.attachQuestion(title: model.title, directory: model.directory)
    }
    
    // MARK: - Question
    
    func questionDidTapClose() {
        router?.detachQuestion()
    }
    
    private func fetchProblemList() {
        dependency.problemService
            .requestElements()
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
        
        let models = elements.map { element -> ProblemContentViewModel in
            return .init(
                directory: element.directory,
                title: element.title,
                content: element.content
            )
        }
        
        presenter.updateModels(models)
    }
    
}
