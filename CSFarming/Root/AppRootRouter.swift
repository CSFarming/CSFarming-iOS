//
//  AppRootRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import RIBs
import HomeInterface
import ArchiveInterface
import ProblemInterface
import RIBsUtil

protocol AppRootInteractable: Interactable, HomeListener, ArchiveListener, ProblemListener {
    var router: AppRootRouting? { get set }
}

protocol AppRootViewControllable: ViewControllable {
    func setViewControllers(_ viewControllables: [ViewControllable])
}

final class AppRootRouter: LaunchRouter<AppRootInteractable, AppRootViewControllable>, AppRootRouting {
    
    private let homeBuilder: HomeBuildable
    private var homeRouting: Routing?
    
    private let archiveBuilder: ArchiveBuildable
    private var archiveRouting: Routing?
    
    private let problemBuilder: ProblemBuildable
    private var problemRouting: Routing?
    
    init(
        interactor: AppRootInteractable,
        viewController: AppRootViewControllable,
        homeBuilder: HomeBuildable,
        archiveBuilder: ArchiveBuildable,
        problemBuilder: ProblemBuildable
    ) {
        self.homeBuilder = homeBuilder
        self.archiveBuilder = archiveBuilder
        self.problemBuilder = problemBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachTabs() {
        guard homeRouting == nil, archiveRouting == nil, problemRouting == nil else { return }
        let homeRouter = homeBuilder.build(withListener: interactor)
        self.homeRouting = homeRouter
        attachChild(homeRouter)
        
        let archiveRouter = archiveBuilder.build(withListener: interactor)
        self.archiveRouting = archiveRouter
        attachChild(archiveRouter)
        
        let problemRouter = problemBuilder.build(withListener: interactor)
        self.problemRouting = problemRouter
        attachChild(problemRouter)
        
        viewController.setViewControllers([
            NavigationControllable(viewControllable: homeRouter.viewControllable),
            NavigationControllable(viewControllable: archiveRouter.viewControllable),
            NavigationControllable(viewControllable: problemRouter.viewControllable)
        ])
    }
    
}
