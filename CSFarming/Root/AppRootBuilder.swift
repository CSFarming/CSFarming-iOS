//
//  AppRootBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import RIBs
import Home
import Problem
import Archive

protocol AppRootDependency: Dependency {}

protocol AppRootBuildable: Buildable {
    func build() -> AppRootRouting
}

final class AppRootBuilder: Builder<AppRootDependency>, AppRootBuildable {
    
    override init(dependency: AppRootDependency) {
        super.init(dependency: dependency)
    }
    
    func build() -> AppRootRouting {
        let component = AppRootComponent(dependency: dependency)
        let viewController = AppRootViewController()
        let interactor = AppRootInteractor(presenter: viewController)
        return AppRootRouter(
            interactor: interactor,
            viewController: viewController,
            homeBuilder: HomeBuilder(dependency: component),
            archiveBuilder: ArchiveBuilder(dependency: component),
            problemBuilder: ProblemBuilder(dependency: component)
        )
    }
    
}
