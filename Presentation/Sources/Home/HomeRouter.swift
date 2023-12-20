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

protocol HomeInteractable: Interactable, MarkdownContentListener {
    var router: HomeRouting? { get set }
    var listener: HomeListener? { get set }
}

protocol HomeViewControllable: ViewControllable {}

final class HomeRouter: ViewableRouter<HomeInteractable, HomeViewControllable>, HomeRouting {
    
    private let markdownContentBuilder: MarkdownContentBuildable
    private var markdownContentRouting: ViewableRouting?
    
    private let homeFarmingBuilder: HomeFarmingBuildable
    private var homeFarmingRouting: ViewableRouting?
    
    init(
        interactor: HomeInteractable,
        viewController: HomeViewControllable,
        markdownContentBuilder: MarkdownContentBuildable,
        homeFarmingBuilder: HomeFarmingBuildable
    ) {
        self.markdownContentBuilder = markdownContentBuilder
        self.homeFarmingBuilder = homeFarmingBuilder
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
    
}
