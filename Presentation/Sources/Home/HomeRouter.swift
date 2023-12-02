//
//  HomeRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import RIBs
import RIBsUtil
import HomeInterface

protocol HomeInteractable: Interactable, HomeListListener {
    var router: HomeRouting? { get set }
    var listener: HomeListener? { get set }
}

protocol HomeViewControllable: ViewControllable {}

final class HomeRouter: ViewableRouter<HomeInteractable, HomeViewControllable>, HomeRouting {
    
    private let homeListBuilder: HomeListBuildable
    private var homeListRouting: ViewableRouting?
    
    init(
        interactor: HomeInteractable,
        viewController: HomeViewControllable,
        homeListBuilder: HomeListBuildable
    ) {
        self.homeListBuilder = homeListBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachHomeList(title: String, path: String) {
        guard homeListRouting == nil else { return }
        let router = homeListBuilder.build(withListener: interactor, title: title, path: path)
        pushRouter(router, animated: true)
        homeListRouting = router
    }
    
    func detachHomeList() {
        guard let router = homeListRouting else { return }
        popRouter(router, animated: true)
        homeListRouting = nil
    }
    
}
