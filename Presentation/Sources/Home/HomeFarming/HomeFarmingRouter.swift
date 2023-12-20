//
//  HomeFarmingRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 12/20/23.
//

import RIBs

protocol HomeFarmingInteractable: Interactable {
    var router: HomeFarmingRouting? { get set }
    var listener: HomeFarmingListener? { get set }
}

protocol HomeFarmingViewControllable: ViewControllable {}

final class HomeFarmingRouter: ViewableRouter<HomeFarmingInteractable, HomeFarmingViewControllable>, HomeFarmingRouting {
    
    override init(interactor: HomeFarmingInteractable, viewController: HomeFarmingViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
