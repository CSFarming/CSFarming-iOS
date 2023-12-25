//
//  QuestionCreateCompleteBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/18/23.
//

import RIBs
import QuestionService

protocol QuestionCreateCompleteDependency: Dependency {
    var questionService: QuestionServiceInterface { get }
}

final class QuestionCreateCompleteComponent: Component<QuestionCreateCompleteDependency>, QuestionCreateCompleteInteractorDependency {
    let title: String
    let subtitle: String
    let category: String
    let questions: [Question]
    var questionService: QuestionServiceInterface { dependency.questionService }
    
    init(dependency: QuestionCreateCompleteDependency, title: String, subtitle: String, category: String, questions: [Question]) {
        self.title = title
        self.subtitle = subtitle
        self.category = category
        self.questions = questions
        super.init(dependency: dependency)
    }
}

protocol QuestionCreateCompleteBuildable: Buildable {
    func build(withListener listener: QuestionCreateCompleteListener, title: String, subtitle: String, category: String, questions: [Question]) -> ViewableRouting
}

final class QuestionCreateCompleteBuilder: Builder<QuestionCreateCompleteDependency>, QuestionCreateCompleteBuildable {
    
    override init(dependency: QuestionCreateCompleteDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: QuestionCreateCompleteListener, title: String, subtitle: String, category: String, questions: [Question]) -> ViewableRouting {
        let component = QuestionCreateCompleteComponent(dependency: dependency, title: title, subtitle: subtitle, category: category, questions: questions)
        let viewController = QuestionCreateCompleteViewController()
        let interactor = QuestionCreateCompleteInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return QuestionCreateCompleteRouter(interactor: interactor, viewController: viewController)
    }
    
}
