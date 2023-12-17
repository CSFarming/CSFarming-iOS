//
//  QuestionCompleteBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/15/23.
//

import RIBs

protocol QuestionCompleteDependency: Dependency {}

final class QuestionCompleteComponent: Component<QuestionCompleteDependency>, QuestionCompleteInteractorDependency {
    
    let questions: [String]
    let answers: [QuestionAnswerType]
    
    init(dependency: QuestionCompleteDependency, questions: [String], answers: [QuestionAnswerType]) {
        self.questions = questions
        self.answers = answers
        super.init(dependency: dependency)
    }
    
}

protocol QuestionCompleteBuildable: Buildable {
    func build(withListener listener: QuestionCompleteListener, questions: [String], answers: [QuestionAnswerType]) -> ViewableRouting
}

final class QuestionCompleteBuilder: Builder<QuestionCompleteDependency>, QuestionCompleteBuildable {
    
    override init(dependency: QuestionCompleteDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: QuestionCompleteListener, questions: [String], answers: [QuestionAnswerType]) -> ViewableRouting {
        let component = QuestionCompleteComponent(dependency: dependency, questions: questions, answers: answers)
        let viewController = QuestionCompleteViewController()
        let interactor = QuestionCompleteInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return QuestionCompleteRouter(interactor: interactor, viewController: viewController)
    }
    
}
