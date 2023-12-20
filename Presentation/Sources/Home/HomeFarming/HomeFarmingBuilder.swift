//
//  HomeFarmingBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/20/23.
//

import RIBs

protocol HomeFarmingDependency: Dependency {}

final class HomeFarmingComponent: Component<HomeFarmingDependency> {}

protocol HomeFarmingBuildable: Buildable {
    func build(withListener listener: HomeFarmingListener) -> HomeFarmingRouting
}

final class HomeFarmingBuilder: Builder<HomeFarmingDependency>, HomeFarmingBuildable {
    
    override init(dependency: HomeFarmingDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: HomeFarmingListener) -> HomeFarmingRouting {
        let component = HomeFarmingComponent(dependency: dependency)
        let viewController = HomeFarmingViewController()
        let interactor = HomeFarmingInteractor(presenter: viewController)
        interactor.listener = listener
        return HomeFarmingRouter(interactor: interactor, viewController: viewController)
    }
    
}
