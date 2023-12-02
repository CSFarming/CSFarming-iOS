//
//  HomeListRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 12/2/23.
//

import RIBs
import RIBsUtil

protocol HomeListInteractable: Interactable, HomeListListener {
    var router: HomeListRouting? { get set }
    var listener: HomeListListener? { get set }
}

protocol HomeListViewControllable: ViewControllable {}

final class HomeListRouter: ViewableRouter<HomeListInteractable, HomeListViewControllable>, HomeListRouting {
    
    private let homeListBuilder: HomeListBuildable
    private var homeListRouting: ViewableRouting?
    
    init(
        interactor: HomeListInteractable,
        viewController: HomeListViewControllable,
        homeListBuilder: HomeListBuildable
    ) {
        self.homeListBuilder = homeListBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachHomeList(title: String, path: String) {
        guard homeListRouting == nil else { return }
        let router = homeListBuilder.build(withListener: interactor, title: title, path: path, isFromRoot: false)
        pushRouter(router, animated: true)
        homeListRouting = router
    }
    
    func detachHomeList() {
        guard let router = homeListRouting else { return }
        popRouter(router, animated: true)
        homeListRouting = nil
    }
    
}
