//
//  AppRootRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import RIBs
import HomeInterface
import RIBsUtil

protocol AppRootInteractable: Interactable, HomeListener {
    var router: AppRootRouting? { get set }
}

protocol AppRootViewControllable: ViewControllable {
    func setViewControllers(_ viewControllables: [ViewControllable])
}

final class AppRootRouter: LaunchRouter<AppRootInteractable, AppRootViewControllable>, AppRootRouting {
    
    private let homeBuilder: HomeBuildable
    private var homeRouting: Routing?
    
    init(
        interactor: AppRootInteractable,
        viewController: AppRootViewControllable,
        homeBuilder: HomeBuildable
    ) {
        self.homeBuilder = homeBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachTabs() {
        guard homeRouting == nil else { return }
        let homeRouter = homeBuilder.build(withListener: interactor)
        self.homeRouting = homeRouter
        attachChild(homeRouter)
        viewController.setViewControllers([
            NavigationControllable(viewControllable: homeRouter.viewControllable)
        ])
    }
    
}
