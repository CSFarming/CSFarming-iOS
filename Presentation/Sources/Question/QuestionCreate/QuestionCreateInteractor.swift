//
//  QuestionCreateInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/17/23.
//

import RIBs
import RxSwift
import QuestionInterface
import QuestionService

protocol QuestionCreateRouting: ViewableRouting {
    func attachComplete(title: String, subtitle: String, questions: [Question])
    func detachComplete()
}

protocol QuestionCreatePresentable: Presentable {
    var listener: QuestionCreatePresentableListener? { get set }
    func appendQuestion(index: Int, title: String)
    func updateEnabled(isEnabled: Bool)
}

final class QuestionCreateInteractor: PresentableInteractor<QuestionCreatePresentable>, QuestionCreateInteractable, QuestionCreatePresentableListener {
    
    weak var router: QuestionCreateRouting?
    weak var listener: QuestionCreateListener?
    
    private var isCreateEnabled: Bool {
        return !title.isEmpty && !subtitle.isEmpty && questions.allSatisfy { $0.isEmpty == false } && answers.allSatisfy { $0.isEmpty == false }
    }
    
    private var title = ""
    private var subtitle = ""
    private var questions: [String] = []
    private var answers: [String] = []
    
    override init(presenter: QuestionCreatePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.updateEnabled(isEnabled: isCreateEnabled)
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapClose() {
        listener?.questionCreateDidTapClose()
    }
    
    func didTapCreate() {
        let questions = zip(questions, answers)
            .map { question, answer in
                return Question(question: question, answer: answer)
            }
        router?.attachComplete(title: title, subtitle: subtitle, questions: questions)
    }
    
    func didTapAddQuestion() {
        appendQuestion()
    }
    
    func titleUpdated(title: String) {
        self.title = title
        presenter.updateEnabled(isEnabled: isCreateEnabled)
    }
    
    func subtitleUpdate(subtitle: String) {
        self.subtitle = subtitle
        presenter.updateEnabled(isEnabled: isCreateEnabled)
    }
    
    func questionUpdated(at index: Int, question: String) {
        questions[index] = question
        presenter.updateEnabled(isEnabled: isCreateEnabled)
    }
    
    func answerUpdated(at index: Int, answer: String) {
        answers[index] = answer
        presenter.updateEnabled(isEnabled: isCreateEnabled)
    }
    
    func viewDidLoad() {
        (0..<3).forEach { _ in appendQuestion() }
    }
    
    func questionCreateCompleteDidTapClose() {
        router?.detachComplete()
    }
    
    func questionCreateCompleteDidFinish() {
        listener?.questionCreateDidCreate()
    }
    
    private func appendQuestion() {
        let index = questions.count
        questions.append("")
        answers.append("")
        presenter.appendQuestion(index: index, title: "질문 \(index + 1)")
    }
    
}
