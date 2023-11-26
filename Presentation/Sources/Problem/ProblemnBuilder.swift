//
//  ProblemBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import RIBs
import ProblemInterface

public protocol ProblemDependency: Dependency {}

final class ProblemComponent: Component<ProblemDependency> {}

public final class ProblemBuilder: Builder<ProblemDependency>, ProblemBuildable {
    
    public override init(dependency: ProblemDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: ProblemListener) -> ViewableRouting {
        let component = ProblemComponent(dependency: dependency)
        let viewController = ProblemViewController()
        let interactor = ProblemInteractor(presenter: viewController)
        interactor.listener = listener
        return ProblemRouter(interactor: interactor, viewController: viewController)
    }
    
}
