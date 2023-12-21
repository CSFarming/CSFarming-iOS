//
//  FarmingHomeRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 12/21/23.
//

import RIBs
import FarmingInterface

protocol FarmingHomeInteractable: Interactable {
    var router: FarmingHomeRouting? { get set }
    var listener: FarmingHomeListener? { get set }
}

protocol FarmingHomeViewControllable: ViewControllable {}

final class FarmingHomeRouter: ViewableRouter<FarmingHomeInteractable, FarmingHomeViewControllable>, FarmingHomeRouting {
    
    override init(interactor: FarmingHomeInteractable, viewController: FarmingHomeViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
