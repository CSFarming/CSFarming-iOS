//
//  ProblemCreateBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/17/23.
//

import RIBs
import QuestionInterface

protocol ProblemCreateDependency: Dependency {
    var questionCreateBuilder: QuestionCreateBuildable { get }
}

final class ProblemCreateComponent: Component<ProblemCreateDependency> {
    var questionBuilder: QuestionCreateBuildable { dependency.questionCreateBuilder }
}

protocol ProblemCreateBuildable: Buildable {
    func build(withListener listener: ProblemCreateListener) -> ViewableRouting
}

final class ProblemCreateBuilder: Builder<ProblemCreateDependency>, ProblemCreateBuildable {
    
    override init(dependency: ProblemCreateDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: ProblemCreateListener) -> ViewableRouting {
        let component = ProblemCreateComponent(dependency: dependency)
        let viewController = ProblemCreateViewController()
        let interactor = ProblemCreateInteractor(presenter: viewController)
        interactor.listener = listener
        return ProblemCreateRouter(
            interactor: interactor, 
            viewController: viewController,
            questionBuilder: component.questionBuilder
        )
    }
    
}
