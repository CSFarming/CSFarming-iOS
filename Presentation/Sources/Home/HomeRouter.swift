//
//  HomeRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import RIBs
import RIBsUtil
import HomeInterface
import MarkdownContentInterface

protocol HomeInteractable: Interactable,
                           MarkdownContentListener,
                           HomeFarmingListener,
                           HomeRecentListener {
    var router: HomeRouting? { get set }
    var listener: HomeListener? { get set }
}

protocol HomeViewControllable: ViewControllable {
    func setDashboard(_ viewControllable: ViewControllable)
    func removeDashboard(_ viewControllable: ViewControllable)
}

final class HomeRouter: ViewableRouter<HomeInteractable, HomeViewControllable>, HomeRouting {
    
    private let markdownContentBuilder: MarkdownContentBuildable
    private var markdownContentRouting: ViewableRouting?
    
    private let homeFarmingBuilder: HomeFarmingBuildable
    private var homeFarmingRouting: ViewableRouting?
    
    private let homeRecentBuilder: HomeRecentBuildable
    private var homeRecentRouting:  ViewableRouting?
    
    init(
        interactor: HomeInteractable,
        viewController: HomeViewControllable,
        markdownContentBuilder: MarkdownContentBuildable,
        homeFarmingBuilder: HomeFarmingBuildable,
        homeRecentBuilder: HomeRecentBuildable
    ) {
        self.markdownContentBuilder = markdownContentBuilder
        self.homeFarmingBuilder = homeFarmingBuilder
        self.homeRecentBuilder = homeRecentBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachMarkdownContent(title: String, path: String) {
        guard markdownContentRouting == nil else { return }
        let router = markdownContentBuilder.build(withListener: interactor, title: title, path: path, isFromRoot: false)
        pushRouter(router, animated: true)
        markdownContentRouting = router
    }
    
    func detachMarkdownContent() {
        guard let router = markdownContentRouting else { return }
        popRouter(router, animated: true)
        markdownContentRouting = nil
    }
    
    func attachHomeFarming() {
        guard homeFarmingRouting == nil else { return }
        let router = homeFarmingBuilder.build(withListener: interactor)
        viewController.setDashboard(router.viewControllable)
        homeFarmingRouting = router
        attachChild(router)
    }
    
    func attachHomeRecent() {
        guard homeRecentRouting == nil else { return }
        let router = homeRecentBuilder.build(withListener: interactor)
        viewController.setDashboard(router.viewControllable)
        homeRecentRouting = router
        attachChild(router)
    }
    
}
