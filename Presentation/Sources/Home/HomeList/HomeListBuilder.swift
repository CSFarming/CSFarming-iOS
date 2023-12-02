//
//  HomeListBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/2/23.
//

import RIBs

protocol HomeListDependency: Dependency {}

final class HomeListComponent: Component<HomeListDependency> {}

protocol HomeListBuildable: Buildable {
    func build(withListener listener: HomeListListener) -> HomeListRouting
}

final class HomeListBuilder: Builder<HomeListDependency>, HomeListBuildable {
    
    override init(dependency: HomeListDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: HomeListListener) -> HomeListRouting {
        let component = HomeListComponent(dependency: dependency)
        let viewController = HomeListViewController()
        let interactor = HomeListInteractor(presenter: viewController)
        interactor.listener = listener
        return HomeListRouter(interactor: interactor, viewController: viewController)
    }
    
}
