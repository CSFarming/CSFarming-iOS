//
//  ProblemBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import RIBs
import ProblemInterface
import ProblemService

public protocol ProblemDependency: Dependency {
    var problemService: ProblemServiceInterface { get }
}

final class ProblemComponent: Component<ProblemDependency>, ProblemInteractorDependency {
    var problemService: ProblemServiceInterface { dependency.problemService }
}

public final class ProblemBuilder: Builder<ProblemDependency>, ProblemBuildable {
    
    public override init(dependency: ProblemDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: ProblemListener) -> ViewableRouting {
        let component = ProblemComponent(dependency: dependency)
        let viewController = ProblemViewController()
        let interactor = ProblemInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return ProblemRouter(interactor: interactor, viewController: viewController)
    }
    
}
