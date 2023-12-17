//
//  QuestionBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/9/23.
//

import RIBs
import QuestionInterface
import QuestionService

public protocol QuestionDependency: Dependency {
    var questionService: QuestionServiceInterface { get }
}

final class QuestionComponent: Component<QuestionDependency>,
                               QuestionCompleteDependency,
                               QuestionInteractorDependency {
    
    let title: String
    let directory: String
    var questionService: QuestionServiceInterface { dependency.questionService }
    
    init(dependency: QuestionDependency, title: String, directory: String) {
        self.title = title
        self.directory = directory
        super.init(dependency: dependency)
    }
    
}

public final class QuestionBuilder: Builder<QuestionDependency>, QuestionBuildable {
    
    public override init(dependency: QuestionDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: QuestionListener, title: String, directory: String) -> ViewableRouting {
        let component = QuestionComponent(dependency: dependency, title: title, directory: directory)
        let viewController = QuestionViewController()
        let interactor = QuestionInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return QuestionRouter(
            interactor: interactor,
            viewController: viewController,
            questionCompleteBuilder: QuestionCompleteBuilder(dependency: component)
        )
    }
}
