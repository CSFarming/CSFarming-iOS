//
//  HomeBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import Foundation
import RIBs
import HomeInterface
import HomeService
import MarkdownContentInterface

public protocol HomeDependency: Dependency {
    var homeService: HomeServiceInterface { get }
    var markdownContentBuilder: MarkdownContentBuildable { get }
    var calendar: Calendar { get }
}

final class HomeComponent: Component<HomeDependency>,
                           HomeInteractorDependency,
                           HomeFarmingDependency,
                           HomeRecentDependency {
    var homeService: HomeServiceInterface { dependency.homeService }
    var markdownContentBuilder: MarkdownContentBuildable { dependency.markdownContentBuilder }
    var calendar: Calendar { dependency.calendar }
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
            markdownContentBuilder: component.markdownContentBuilder,
            homeFarmingBuilder: HomeFarmingBuilder(dependency: component),
            homeRecentBuilder: HomeRecentBuilder(dependency: component)
        )
    }
    
}
