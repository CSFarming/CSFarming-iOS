//
//  FarmingChartBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/26/23.
//

import RIBs
import FarmingService

protocol FarmingChartDependency: Dependency {
    var farmingService: FarmingServiceInterface { get }
}

final class FarmingChartComponent: Component<FarmingChartDependency>, FarmingChartInteractorDependency {
    var farmingService: FarmingServiceInterface { dependency.farmingService }
}

protocol FarmingChartBuildable: Buildable {
    func build(withListener listener: FarmingChartListener) -> FarmingChartRouting
}

final class FarmingChartBuilder: Builder<FarmingChartDependency>, FarmingChartBuildable {
    
    override init(dependency: FarmingChartDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: FarmingChartListener) -> FarmingChartRouting {
        let component = FarmingChartComponent(dependency: dependency)
        let viewController = FarmingChartViewController()
        let interactor = FarmingChartInteractor(
            presenter: viewController,
            dependency: component
        )
        interactor.listener = listener
        return FarmingChartRouter(interactor: interactor, viewController: viewController)
    }
    
}
