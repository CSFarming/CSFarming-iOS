//
//  QuestionBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/9/23.
//

import RIBs

protocol QuestionDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class QuestionComponent: Component<QuestionDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}



final class QuestionBuilder: Builder<QuestionDependency>, QuestionBuildable {

    override init(dependency: QuestionDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: QuestionListener) -> ViewableRouting {
        let component = QuestionComponent(dependency: dependency)
        let viewController = QuestionViewController()
        let interactor = QuestionInteractor(presenter: viewController)
        interactor.listener = listener
        return QuestionRouter(interactor: interactor, viewController: viewController)
    }
}
