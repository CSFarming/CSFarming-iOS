//
//  ProblemInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import Foundation
import RIBs
import RxSwift
import ProblemInterface
import ProblemService
import QuestionService

protocol ProblemRouting: ViewableRouting {
    func attachQuestion(title: String, directory: String)
    func detachQuestion()
    func attachProblem(title: String, directory: String)
    func detachProblem()
    func attachProblemCreate()
    func detachProblemCreate()
}

protocol ProblemPresentable: Presentable {
    var listener: ProblemPresentableListener? { get set }
    func updateSections(_ sections: [ProblemSection])
}

protocol ProblemInteractorDependency: AnyObject {
    var problemService: ProblemServiceInterface { get }
    var questionService: QuestionServiceInterface { get }
}

final class ProblemInteractor: PresentableInteractor<ProblemPresentable>, ProblemInteractable, ProblemPresentableListener {
    
    weak var router: ProblemRouting?
    weak var listener: ProblemListener?
    
    private var problemElements: [ProblemElement] = []
    private var questionElements: [QuestionElement] = []
    private var sections: [ProblemSection] = []
    
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
    
    func didTap(at indexPath: IndexPath) {
        guard let section = sections[safe: indexPath.section] else { return }
        switch section {
        case .remote:
            guard let item = problemElements[safe: indexPath.item] else { return }
            switch item.type {
            case .list:
                router?.attachProblem(title: item.title, directory: item.directory)
                
            case .question:
                router?.attachQuestion(title: item.title, directory: item.directory)
            }
            
        case .local:
            guard let item = questionElements[safe: indexPath.item] else { return }
            print("Attach Local Question: \(item)")
            
        }
    }
    
    func didTapCreate() {
        router?.attachProblemCreate()
    }
    
    // MARK: - Question
    
    func questionDidTapClose() {
        router?.detachQuestion()
    }
    
    // MARK: - ProblemList
    
    func problemListDidTapClose() {
        router?.detachProblem()
    }
    
    // MARK: - ProblemCreate
    
    func problemCreateDidTapClose() {
        router?.detachProblemCreate()
    }
    
    func problemCreateDidCreate() {
        router?.detachProblemCreate()
    }
    
    private func fetchProblemList() {
        Observable.zip(
            dependency.problemService.requestElements().asObservable(),
            dependency.questionService.requestLocalQuestions().asObservable()
        )
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                with: self,
                onNext: { this, elements in
                    this.performAfterFetchingList(elements)
                },
                onError: { this, error in
                    print(error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func performAfterFetchingList(_ elements: ([ProblemElement], [QuestionElement])) {
        problemElements = elements.0
        questionElements = elements.1
        
        sections = makeSections(problems: problemElements, questions: questionElements)
        presenter.updateSections(sections)
    }
    
    private func makeSections(problems: [ProblemElement], questions: [QuestionElement]) -> [ProblemSection] {
        var sections: [ProblemSection] = []
        
        sections.append(.remote(problems.map { $0.toModel() }))
        
        if !questions.isEmpty {
            sections.append(.local(questions.map { $0.toModel() }))
        }
        return sections
    }
    
}

private extension ProblemElement {
    
    func toModel() -> ProblemItem {
        return .remote(.init(title: title, content: content))
    }
    
}

private extension QuestionElement {
    
    func toModel() -> ProblemItem {
        return .local(.init(title: title, subtitle: subtitle))
    }
    
}
