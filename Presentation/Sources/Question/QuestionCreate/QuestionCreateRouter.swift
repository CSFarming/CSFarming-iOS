//
//  QuestionCreateRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 12/17/23.
//

import RIBs
import QuestionInterface

protocol QuestionCreateInteractable: Interactable {
    var router: QuestionCreateRouting? { get set }
    var listener: QuestionCreateListener? { get set }
}

protocol QuestionCreateViewControllable: ViewControllable {}

final class QuestionCreateRouter: ViewableRouter<QuestionCreateInteractable, QuestionCreateViewControllable>, QuestionCreateRouting {
    
    override init(interactor: QuestionCreateInteractable, viewController: QuestionCreateViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
