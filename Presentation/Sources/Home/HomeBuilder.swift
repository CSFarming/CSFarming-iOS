//
//  HomeBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import RIBs
import HomeInterface
import HomeService

public protocol HomeDependency: Dependency {
    var homeService: HomeServiceInterface { get }
}

final class HomeComponent: Component<HomeDependency>,
                           HomeInteractorDependency,
                           HomeListDependency {
    var homeService: HomeServiceInterface { dependency.homeService }
}

public final class HomeBuilder: Builder<HomeDependency>, HomeBuildable {
    
    public override init(dependency: HomeDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: HomeListener) -> ViewableRouting {
        let component = HomeComponent(dependency: dependency)
        let viewController = HomeViewController()
        let interactor = HomeInteractor(
            presenter: viewController,
            dependency: component
        )
        interactor.listener = listener
        return HomeRouter(
            interactor: interactor,
            viewController: viewController,
            homeListBuilder: HomeListBuilder(dependency: component)
        )
    }
    
}
