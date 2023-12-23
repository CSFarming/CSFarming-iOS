//
//  FarmingQuestionBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/23/23.
//

import RIBs
import FarmingService

protocol FarmingQuestionDependency: Dependency {}

final class FarmingQuestionComponent: Component<FarmingQuestionDependency>, FarmingQuestionInteractorDependency {
    let element: FarmingProblemElement
    
    init(dependency: FarmingQuestionDependency, element: FarmingProblemElement) {
        self.element = element
        super.init(dependency: dependency)
    }
}

protocol FarmingQuestionBuildable: Buildable {
    func build(withListener listener: FarmingQuestionListener, element: FarmingProblemElement) -> ViewableRouting
}

final class FarmingQuestionBuilder: Builder<FarmingQuestionDependency>, FarmingQuestionBuildable {
    
    override init(dependency: FarmingQuestionDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: FarmingQuestionListener, element: FarmingProblemElement) -> ViewableRouting {
        let component = FarmingQuestionComponent(dependency: dependency, element: element)
        let viewController = FarmingQuestionViewController()
        let interactor = FarmingQuestionInteractor(presenter: viewController, depenedency: component)
        interactor.listener = listener
        return FarmingQuestionRouter(interactor: interactor, viewController: viewController)
    }
    
}
