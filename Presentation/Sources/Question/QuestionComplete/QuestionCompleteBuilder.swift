//
//  QuestionCompleteBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/15/23.
//

import RIBs
import QuestionService

protocol QuestionCompleteDependency: Dependency {
    var questionService: QuestionServiceInterface { get }
}

final class QuestionCompleteComponent: Component<QuestionCompleteDependency>, QuestionCompleteInteractorDependency {
    
    let questions: [Question]
    let answers: [QuestionAnswerType]
    var questionService: QuestionServiceInterface { dependency.questionService }
    
    init(dependency: QuestionCompleteDependency, questions: [Question], answers: [QuestionAnswerType]) {
        self.questions = questions
        self.answers = answers
        super.init(dependency: dependency)
    }
    
}

protocol QuestionCompleteBuildable: Buildable {
    func build(withListener listener: QuestionCompleteListener, questions: [Question], answers: [QuestionAnswerType]) -> ViewableRouting
}

final class QuestionCompleteBuilder: Builder<QuestionCompleteDependency>, QuestionCompleteBuildable {
    
    override init(dependency: QuestionCompleteDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: QuestionCompleteListener, questions: [Question], answers: [QuestionAnswerType]) -> ViewableRouting {
        let component = QuestionCompleteComponent(dependency: dependency, questions: questions, answers: answers)
        let viewController = QuestionCompleteViewController()
        let interactor = QuestionCompleteInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return QuestionCompleteRouter(interactor: interactor, viewController: viewController)
    }
    
}
