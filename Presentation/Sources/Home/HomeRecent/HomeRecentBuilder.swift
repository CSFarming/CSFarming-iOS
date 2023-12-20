//
//  HomeRecentBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/20/23.
//

import RIBs
import HomeService

protocol HomeRecentDependency: Dependency {
    var homeService: HomeServiceInterface { get }
}

final class HomeRecentComponent: Component<HomeRecentDependency>, HomeRecentInteractorDependency {
    var homeService: HomeServiceInterface { dependency.homeService }
}

protocol HomeRecentBuildable: Buildable {
    func build(withListener listener: HomeRecentListener) -> ViewableRouting
}

final class HomeRecentBuilder: Builder<HomeRecentDependency>, HomeRecentBuildable {
    
    override init(dependency: HomeRecentDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: HomeRecentListener) -> ViewableRouting {
        let component = HomeRecentComponent(dependency: dependency)
        let viewController = HomeRecentViewController()
        let interactor = HomeRecentInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return HomeRecentRouter(interactor: interactor, viewController: viewController)
    }
    
}
