//
//  HomeFarmingBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/20/23.
//

import Foundation
import RIBs
import HomeService

protocol HomeFarmingDependency: Dependency {
    var homeService: HomeServiceInterface { get }
}

final class HomeFarmingComponent: Component<HomeFarmingDependency>, HomeFarmingInteractorDependency {
    var homeService: HomeServiceInterface { dependency.homeService }
}

protocol HomeFarmingBuildable: Buildable {
    func build(withListener listener: HomeFarmingListener) -> ViewableRouting
}

final class HomeFarmingBuilder: Builder<HomeFarmingDependency>, HomeFarmingBuildable {
    
    override init(dependency: HomeFarmingDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: HomeFarmingListener) -> ViewableRouting {
        let component = HomeFarmingComponent(dependency: dependency)
        let viewController = HomeFarmingViewController()
        let interactor = HomeFarmingInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return HomeFarmingRouter(interactor: interactor, viewController: viewController)
    }
    
}
