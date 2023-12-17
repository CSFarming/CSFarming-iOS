//
//  QuestionCreateBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/17/23.
//

import RIBs

protocol QuestionCreateDependency: Dependency {}

final class QuestionCreateComponent: Component<QuestionCreateDependency> {}

protocol QuestionCreateBuildable: Buildable {
    func build(withListener listener: QuestionCreateListener) -> ViewableRouting
}

final class QuestionCreateBuilder: Builder<QuestionCreateDependency>, QuestionCreateBuildable {
    
    override init(dependency: QuestionCreateDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: QuestionCreateListener) -> ViewableRouting {
        let component = QuestionCreateComponent(dependency: dependency)
        let viewController = QuestionCreateViewController()
        let interactor = QuestionCreateInteractor(presenter: viewController)
        interactor.listener = listener
        return QuestionCreateRouter(interactor: interactor, viewController: viewController)
    }
    
}
