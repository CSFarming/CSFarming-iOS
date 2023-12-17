//
//  QuestionCreateBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/17/23.
//

import RIBs
import QuestionInterface

public protocol QuestionCreateDependency: Dependency {}

final class QuestionCreateComponent: Component<QuestionCreateDependency> {}

public final class QuestionCreateBuilder: Builder<QuestionCreateDependency>, QuestionCreateBuildable {
    
    public override init(dependency: QuestionCreateDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: QuestionCreateListener) -> ViewableRouting {
        let component = QuestionCreateComponent(dependency: dependency)
        let viewController = QuestionCreateViewController()
        let interactor = QuestionCreateInteractor(presenter: viewController)
        interactor.listener = listener
        return QuestionCreateRouter(interactor: interactor, viewController: viewController)
    }
    
}
