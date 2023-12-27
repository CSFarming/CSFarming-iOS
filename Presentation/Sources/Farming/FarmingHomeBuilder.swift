//
//  FarmingHomeBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/21/23.
//

import RIBs
import FarmingInterface
import FarmingService

public protocol FarmingHomeDependency: Dependency {
    var farmingService: FarmingServiceInterface { get }
}

final class FarmingHomeComponent: Component<FarmingHomeDependency>,
                                  FarmingHomeInteractorDependency,
                                  FarmingQuestionDependency,
                                  FarmingChartDependency {
    var farmingService: FarmingServiceInterface { dependency.farmingService }
}

public final class FarmingHomeBuilder: Builder<FarmingHomeDependency>, FarmingHomeBuildable {
    
    public override init(dependency: FarmingHomeDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: FarmingHomeListener) -> ViewableRouting {
        let component = FarmingHomeComponent(dependency: dependency)
        let viewController = FarmingHomeViewController()
        let interactor = FarmingHomeInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return FarmingHomeRouter(
            interactor: interactor,
            viewController: viewController,
            farmingQuestionBuiler: FarmingQuestionBuilder(dependency: component),
            farmingChartBuilder: FarmingChartBuilder(dependency: component)
        )
    }
    
}
