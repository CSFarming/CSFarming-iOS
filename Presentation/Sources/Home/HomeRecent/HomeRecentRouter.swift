//
//  HomeRecentRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 12/20/23.
//

import RIBs

protocol HomeRecentInteractable: Interactable {
    var router: HomeRecentRouting? { get set }
    var listener: HomeRecentListener? { get set }
}

protocol HomeRecentViewControllable: ViewControllable {}

final class HomeRecentRouter: ViewableRouter<HomeRecentInteractable, HomeRecentViewControllable>, HomeRecentRouting {
    
    override init(interactor: HomeRecentInteractable, viewController: HomeRecentViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
