//
//  ProblemCreateRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 12/17/23.
//

import RIBs

protocol ProblemCreateInteractable: Interactable {
    var router: ProblemCreateRouting? { get set }
    var listener: ProblemCreateListener? { get set }
}

protocol ProblemCreateViewControllable: ViewControllable {}

final class ProblemCreateRouter: ViewableRouter<ProblemCreateInteractable, ProblemCreateViewControllable>, ProblemCreateRouting {
    
    override init(interactor: ProblemCreateInteractable, viewController: ProblemCreateViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
