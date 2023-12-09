//
//  QuestionRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 12/9/23.
//

import RIBs
import QuestionInterface

protocol QuestionInteractable: Interactable {
    var router: QuestionRouting? { get set }
    var listener: QuestionListener? { get set }
}

protocol QuestionViewControllable: ViewControllable {}

final class QuestionRouter: ViewableRouter<QuestionInteractable, QuestionViewControllable>, QuestionRouting {
    
    override init(interactor: QuestionInteractable, viewController: QuestionViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
