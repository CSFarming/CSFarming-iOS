//
//  HomeListBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/2/23.
//

import RIBs
import HomeService
import MarkdownContentInterface

protocol HomeListDependency: Dependency {
    var homeService: HomeServiceInterface { get }
    var markdownContentBuilder: MarkdownContentBuildable { get }
}

final class HomeListComponent: Component<HomeListDependency>, HomeListInteractorDependency {
    
    var homeService: HomeServiceInterface { dependency.homeService }
    var markdownContentBuilder: MarkdownContentBuildable { dependency.markdownContentBuilder }
    let title: String
    let path: String
    let isFromRoot: Bool
    
    init(dependency: HomeListDependency, title: String, path: String, isFromRoot: Bool) {
        self.title = title
        self.path = path
        self.isFromRoot = isFromRoot
        super.init(dependency: dependency)
    }
    
}

protocol HomeListBuildable: Buildable {
    func build(withListener listener: HomeListListener, title: String, path: String, isFromRoot: Bool) -> ViewableRouting
}

final class HomeListBuilder: Builder<HomeListDependency>, HomeListBuildable {
    
    override init(dependency: HomeListDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: HomeListListener, title: String, path: String, isFromRoot: Bool) -> ViewableRouting {
        let component = HomeListComponent(
            dependency: dependency,
            title: title,
            path: path,
            isFromRoot: isFromRoot
        )
        let viewController = HomeListViewController()
        let interactor = HomeListInteractor(
            presenter: viewController, 
            dependency: component
        )
        interactor.listener = listener
        return HomeListRouter(
            interactor: interactor,
            viewController: viewController,
            homeListBuilder: self,
            markdownContentBuilder: component.markdownContentBuilder
        )
    }
    
}
