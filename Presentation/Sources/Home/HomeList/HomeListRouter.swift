//
//  HomeListRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 12/2/23.
//

import RIBs

protocol HomeListInteractable: Interactable {
    var router: HomeListRouting? { get set }
    var listener: HomeListListener? { get set }
}

protocol HomeListViewControllable: ViewControllable {}

final class HomeListRouter: ViewableRouter<HomeListInteractable, HomeListViewControllable>, HomeListRouting {
    
    override init(interactor: HomeListInteractable, viewController: HomeListViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
