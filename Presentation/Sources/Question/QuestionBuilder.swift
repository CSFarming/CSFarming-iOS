//
//  QuestionBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/9/23.
//

import RIBs
import QuestionInterface

protocol QuestionDependency: Dependency {}

final class QuestionComponent: Component<QuestionDependency> {}

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
