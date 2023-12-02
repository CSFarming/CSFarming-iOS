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

protocol HomeInteractable: Interactable, HomeListListener, MarkdownContentListener {
    var router: HomeRouting? { get set }
    var listener: HomeListener? { get set }
}

protocol HomeViewControllable: ViewControllable {}

final class HomeRouter: ViewableRouter<HomeInteractable, HomeViewControllable>, HomeRouting {
    
    private let homeListBuilder: HomeListBuildable
    private var homeListRouting: ViewableRouting?
    
    private let markdownContentBuilder: MarkdownContentBuildable
    private var markdownContentRouting: ViewableRouting?
    
    init(
        interactor: HomeInteractable,
        viewController: HomeViewControllable,
        homeListBuilder: HomeListBuildable,
        markdownContentBuilder: MarkdownContentBuildable
    ) {
        self.homeListBuilder = homeListBuilder
        self.markdownContentBuilder = markdownContentBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachHomeList(title: String, path: String) {
        guard homeListRouting == nil else { return }
        let router = homeListBuilder.build(withListener: interactor, title: title, path: path, isFromRoot: true)
        pushRouter(router, animated: true)
        homeListRouting = router
    }
    
    func detachHomeList() {
        guard let router = homeListRouting else { return }
        popRouter(router, animated: true)
        homeListRouting = nil
    }
    
    func attachMarkdownContent(title: String, path: String) {
        guard markdownContentRouting == nil else { return }
        let router = markdownContentBuilder.build(withListener: interactor, title: title, path: path, isFromRoot: true)
        pushRouter(router, animated: true)
        markdownContentRouting = router
    }
    
    func detachMarkdownContent() {
        guard let router = markdownContentRouting else { return }
        popRouter(router, animated: true)
        markdownContentRouting = nil
    }
    
}
