//
//  QuestionCompleteBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/15/23.
//

import RIBs

protocol QuestionCompleteDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class QuestionCompleteComponent: Component<QuestionCompleteDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol QuestionCompleteBuildable: Buildable {
    func build(withListener listener: QuestionCompleteListener) -> QuestionCompleteRouting
}

final class QuestionCompleteBuilder: Builder<QuestionCompleteDependency>, QuestionCompleteBuildable {

    override init(dependency: QuestionCompleteDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: QuestionCompleteListener) -> QuestionCompleteRouting {
        let component = QuestionCompleteComponent(dependency: dependency)
        let viewController = QuestionCompleteViewController()
        let interactor = QuestionCompleteInteractor(presenter: viewController)
        interactor.listener = listener
        return QuestionCompleteRouter(interactor: interactor, viewController: viewController)
    }
}
