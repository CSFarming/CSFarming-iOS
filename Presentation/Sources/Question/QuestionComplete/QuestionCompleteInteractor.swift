//
//  QuestionCompleteInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/15/23.
//

import Foundation
import RIBs
import RxSwift
import CoreUtil
import QuestionService
import FarmingService

protocol QuestionCompleteRouting: ViewableRouting {}

protocol QuestionCompletePresentable: Presentable {
    var listener: QuestionCompletePresentableListener? { get set }
    func updateTitle(_ title: String)
    func updateSections(_ sections: [QuestionCompleteSection])
    func updateModel(at indexPath: IndexPath, model: QuestionCompleteCellModel)
}

protocol QuestionCompleteListener: AnyObject {
    func questionCompleteDidTapDone()
}

protocol QuestionCompleteInteractorDependency: AnyObject {
    var title: String { get }
    var category: String { get }
    var questions: [Question] { get }
    var answers: [QuestionAnswerType] { get }
    var questionService: QuestionServiceInterface { get }
}

final class QuestionCompleteInteractor: PresentableInteractor<QuestionCompletePresentable>, QuestionCompleteInteractable, QuestionCompletePresentableListener {
    
    weak var router: QuestionCompleteRouting?
    weak var listener: QuestionCompleteListener?
    
    private let dependency: QuestionCompleteInteractorDependency
    private var sections: [QuestionCompleteSection] = []
    private let disposeBag = DisposeBag()
    
    init(
        presenter: QuestionCompletePresentable,
        dependency: QuestionCompleteInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        updatePresentable()
        requestVisited()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTap(at indexPath: IndexPath) {
        guard let model = sections[safe: indexPath.section]?.items[safe: indexPath.row] else {
            return
        }
        let newModel = QuestionCompleteCellModel(question: model.question, answer: model.answer, isOpened: !model.isOpened)
        sections = sections.updating(at: indexPath, model: newModel)
        presenter.updateModel(at: indexPath, model: newModel)
    }
    
    func didTapDone() {
        listener?.questionCompleteDidTapDone()
    }
    
    private func updatePresentable() {
        presenter.updateTitle("결과")
        
        var okModels: [QuestionCompleteCellModel] = []
        var passModels: [QuestionCompleteCellModel] = []
        
        zip(dependency.questions, dependency.answers)
            .forEach { question, answer in
                let model = QuestionCompleteCellModel(question: question.question, answer: question.answer, isOpened: false)
                switch answer {
                case .ok: okModels.append(model)
                case .pass: passModels.append(model)
                }
            }
        
        var newSections: [QuestionCompleteSection] = []
        
        if okModels.isEmpty == false {
            newSections.append(.ok(okModels))
        }
        
        if passModels.isEmpty == false {
            newSections.append(.pass(passModels))
        }
        
        self.sections = newSections
        presenter.updateSections(newSections)
    }
    
    private func requestVisited() {
        dependency.questionService.insertQuestionResult(
            title: dependency.title,
            category: dependency.category,
            items: generateFarmingItems()
        )
        .subscribe(
            onSuccess: { _ in
                print("# Question Farming 성공적으로 저장")
            },
            onFailure: { error in
                print("# Question Farming 저장 실패: \(error.localizedDescription)")
            }
        )
        .disposed(by: disposeBag)
    }
    
    private func generateFarmingItems() -> [FarmingProblemElementItem] {
        return zip(dependency.questions, dependency.answers)
            .map { question, answer in
                let isCorrect = answer == .ok
                return .init(question: question.question, answer: question.answer, isCorrect: isCorrect)
            }
    }
    
}
