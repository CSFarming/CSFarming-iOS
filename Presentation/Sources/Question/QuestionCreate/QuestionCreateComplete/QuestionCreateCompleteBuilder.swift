//
//  QuestionCreateCompleteBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/18/23.
//

import RIBs

protocol QuestionCreateCompleteDependency: Dependency {}

final class QuestionCreateCompleteComponent: Component<QuestionCreateCompleteDependency> {}

protocol QuestionCreateCompleteBuildable: Buildable {
    func build(withListener listener: QuestionCreateCompleteListener) -> QuestionCreateCompleteRouting
}

final class QuestionCreateCompleteBuilder: Builder<QuestionCreateCompleteDependency>, QuestionCreateCompleteBuildable {
    
    override init(dependency: QuestionCreateCompleteDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: QuestionCreateCompleteListener) -> QuestionCreateCompleteRouting {
        let component = QuestionCreateCompleteComponent(dependency: dependency)
        let viewController = QuestionCreateCompleteViewController()
        let interactor = QuestionCreateCompleteInteractor(presenter: viewController)
        interactor.listener = listener
        return QuestionCreateCompleteRouter(interactor: interactor, viewController: viewController)
    }
    
}
