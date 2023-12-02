//
//  HomeListBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/2/23.
//

import RIBs
import HomeService

protocol HomeListDependency: Dependency {
    var homeService: HomeServiceInterface { get }
}

final class HomeListComponent: Component<HomeListDependency>, HomeListInteractorDependency {
    
    var homeService: HomeServiceInterface { dependency.homeService }
    let title: String
    let path: String
    
    init(dependency: HomeListDependency, title: String, path: String) {
        self.title = title
        self.path = path
        super.init(dependency: dependency)
    }
    
}

protocol HomeListBuildable: Buildable {
    func build(withListener listener: HomeListListener, title: String, path: String) -> ViewableRouting
}

final class HomeListBuilder: Builder<HomeListDependency>, HomeListBuildable {
    
    override init(dependency: HomeListDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: HomeListListener, title: String, path: String) -> ViewableRouting {
        let component = HomeListComponent(
            dependency: dependency,
            title: title,
            path: path
        )
        let viewController = HomeListViewController()
        let interactor = HomeListInteractor(
            presenter: viewController, 
            dependency: component
        )
        interactor.listener = listener
        return HomeListRouter(interactor: interactor, viewController: viewController)
    }
    
}
