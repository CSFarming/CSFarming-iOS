//
//  QuestionInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/9/23.
//

import RIBs
import RxSwift
import QuestionInterface
import QuestionService
import CoreUtil

protocol QuestionRouting: ViewableRouting {
    func attachQuestionComplete(questions: [Question], answers: [QuestionAnswerType])
}

protocol QuestionPresentable: Presentable {
    var listener: QuestionPresentableListener? { get set }
    func setup(title: String)
    func setup(model: QuestionViewControllerModel)
}

protocol QuestionInteractorDependency: AnyObject {
    var title: String { get }
    var directory: String { get }
    var questionService: QuestionServiceInterface { get }
}

final class QuestionInteractor: PresentableInteractor<QuestionPresentable>, QuestionInteractable, QuestionPresentableListener {
    
    weak var router: QuestionRouting?
    weak var listener: QuestionListener?
    
    private let dependency: QuestionInteractorDependency
    private let disposeBag = DisposeBag()
    
    private var questions: [Question] = []
    private var questionIndex = 0
    private var answers: [QuestionAnswerType] = []
    
    init(
        presenter: QuestionPresentable,
        dependency: QuestionInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.setup(title: dependency.title)
        fetchQuestionList()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapClose() {
        listener?.questionDidTapClose()
    }
    
    func didTapOK() {
        answers.append(.ok)
        questionIndex += 1
        updateNextStep()
    }
    
    func didTapPass() {
        answers.append(.pass)
        questionIndex += 1
        updateNextStep()
    }
    
    func questionCompleteDidTapDone() {
        listener?.questionDidTapClose()
    }
    
    private func updateNextStep() {
        guard let question = questions[safe: questionIndex] else {
            router?.attachQuestionComplete(questions: questions, answers: answers)
            return
        }
        
        presenter.setup(model: .init(
            title: "질문 \(questionIndex + 1)", 
            question: question.question,
            progress: Float(answers.count) / Float(questions.count)
        ))
    }
    
    private func fetchQuestionList() {
        dependency.questionService
            .requestQuestions(directory: dependency.directory)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                with: self,
                onSuccess: { this, list in
                    this.performAfterFecthingQuestionList(list)
                },
                onFailure: { this, error in
                    print(error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func performAfterFecthingQuestionList(_ list: QuestionList) {
        questions = list.questions
        updateNextStep()
    }
    
}
