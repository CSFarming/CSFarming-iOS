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

final class QuestionComponent: Component<QuestionDependency>, QuestionInteractorDependency {
    
    let directory: String
    var questionService: QuestionServiceInterface { dependency.questionService }
    
    init(dependency: QuestionDependency, directory: String) {
        self.directory = directory
        super.init(dependency: dependency)
    }
    
}

public final class QuestionBuilder: Builder<QuestionDependency>, QuestionBuildable {

    public override init(dependency: QuestionDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: QuestionListener, directory: String) -> ViewableRouting {
        let component = QuestionComponent(dependency: dependency, directory: directory)
        let viewController = QuestionViewController()
        let interactor = QuestionInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return QuestionRouter(interactor: interactor, viewController: viewController)
    }
}
