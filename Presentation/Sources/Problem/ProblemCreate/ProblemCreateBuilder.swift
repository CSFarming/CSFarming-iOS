//
//  ProblemCreateBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/17/23.
//

import RIBs

protocol ProblemCreateDependency: Dependency {}

final class ProblemCreateComponent: Component<ProblemCreateDependency> {}

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
        return ProblemCreateRouter(interactor: interactor, viewController: viewController)
    }
    
}
