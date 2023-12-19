//
//  QuestionMock.swift
//
//
//  Created by 홍성준 on 12/19/23.
//

@testable import Question
import RIBs
import RIBsTestUtil
import QuestionService
import QuestionServiceTestUtil

final class QuestionPresentableMock: QuestionPresentable {
    
    var listener: QuestionPresentableListener?
    
    var setupTitleCallCount = 0
    var setupTitleTitle: String?
    func setup(title: String) {
        setupTitleCallCount += 1
        setupTitleTitle = title
    }
    
    var setupModelCallCount = 0
    var setupModelModel: QuestionViewControllerModel?
    func setup(model: QuestionViewControllerModel) {
        setupModelCallCount += 1
        setupModelModel = model
    }
    
}

final class QuestionInteractorDependencyMock: QuestionInteractorDependency {
    
    var title: String
    var directory: String
    var questionService: QuestionServiceInterface { questionServiceMock }
    let questionServiceMock: QuestionServiceMock
    
    init(title: String, directory: String) {
        self.title = title
        self.directory = directory
        self.questionServiceMock = QuestionServiceMock()
    }
    
}

final class QuestionRouterMock: ViewableRoutingMock, QuestionRouting {
    
    init(interactable: Interactable) {
        super.init(viewControllable: ViewControllerMock(), interactable: interactable)
    }
    
    var attachQuestionCompleteQuestionsAnswersCallCount = 0
    var attachQuestionCompleteQuestionsAnswersQuestions: [Question]?
    var attachQuestionCompleteQuestionsAnswersAnswers: [QuestionAnswerType]?
    func attachQuestionComplete(questions: [Question], answers: [QuestionAnswerType]) {
        attachQuestionCompleteQuestionsAnswersCallCount += 1
        attachQuestionCompleteQuestionsAnswersQuestions = questions
        attachQuestionCompleteQuestionsAnswersAnswers = answers
    }
    
}
