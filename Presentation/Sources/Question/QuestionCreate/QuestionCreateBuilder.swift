//
//  QuestionCreateBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/17/23.
//

import RIBs
import QuestionInterface
import QuestionService

public protocol QuestionCreateDependency: Dependency {
    var questionService: QuestionServiceInterface { get }
}

final class QuestionCreateComponent: Component<QuestionCreateDependency>, QuestionCreateCompleteDependency {
    var questionService: QuestionServiceInterface { dependency.questionService }
}

public final class QuestionCreateBuilder: Builder<QuestionCreateDependency>, QuestionCreateBuildable {
    
    public override init(dependency: QuestionCreateDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: QuestionCreateListener) -> ViewableRouting {
        let component = QuestionCreateComponent(dependency: dependency)
        let viewController = QuestionCreateViewController()
        let interactor = QuestionCreateInteractor(presenter: viewController)
        interactor.listener = listener
        return QuestionCreateRouter(
            interactor: interactor, 
            viewController: viewController,
            completeBuilder: QuestionCreateCompleteBuilder(dependency: component)
        )
    }
    
}
