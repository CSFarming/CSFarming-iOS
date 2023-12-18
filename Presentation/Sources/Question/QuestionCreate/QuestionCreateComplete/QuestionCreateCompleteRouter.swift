//
//  QuestionCreateCompleteRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 12/18/23.
//

import RIBs

protocol QuestionCreateCompleteInteractable: Interactable {
    var router: QuestionCreateCompleteRouting? { get set }
    var listener: QuestionCreateCompleteListener? { get set }
}

protocol QuestionCreateCompleteViewControllable: ViewControllable {}

final class QuestionCreateCompleteRouter: ViewableRouter<QuestionCreateCompleteInteractable, QuestionCreateCompleteViewControllable>, QuestionCreateCompleteRouting {
    
    override init(interactor: QuestionCreateCompleteInteractable, viewController: QuestionCreateCompleteViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
