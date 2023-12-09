//
//  ProblemListRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 12/9/23.
//

import RIBs

protocol ProblemListInteractable: Interactable {
    var router: ProblemListRouting? { get set }
    var listener: ProblemListListener? { get set }
}

protocol ProblemListViewControllable: ViewControllable {}

final class ProblemListRouter: ViewableRouter<ProblemListInteractable, ProblemListViewControllable>, ProblemListRouting {
    
    override init(interactor: ProblemListInteractable, viewController: ProblemListViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
