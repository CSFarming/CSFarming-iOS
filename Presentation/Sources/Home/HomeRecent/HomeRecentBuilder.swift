//
//  HomeRecentBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/20/23.
//

import RIBs

protocol HomeRecentDependency: Dependency {}

final class HomeRecentComponent: Component<HomeRecentDependency> {}

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
        let interactor = HomeRecentInteractor(presenter: viewController)
        interactor.listener = listener
        return HomeRecentRouter(interactor: interactor, viewController: viewController)
    }
    
}
