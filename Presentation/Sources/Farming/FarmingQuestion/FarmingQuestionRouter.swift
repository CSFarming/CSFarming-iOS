//
//  FarmingQuestionRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 12/23/23.
//

import RIBs

protocol FarmingQuestionInteractable: Interactable {
    var router: FarmingQuestionRouting? { get set }
    var listener: FarmingQuestionListener? { get set }
}

protocol FarmingQuestionViewControllable: ViewControllable {}

final class FarmingQuestionRouter: ViewableRouter<FarmingQuestionInteractable, FarmingQuestionViewControllable>, FarmingQuestionRouting {
    
    override init(interactor: FarmingQuestionInteractable, viewController: FarmingQuestionViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
