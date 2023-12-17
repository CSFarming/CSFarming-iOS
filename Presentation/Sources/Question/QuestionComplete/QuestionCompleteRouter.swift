//
//  QuestionCompleteRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 12/15/23.
//

import RIBs

protocol QuestionCompleteInteractable: Interactable {
    var router: QuestionCompleteRouting? { get set }
    var listener: QuestionCompleteListener? { get set }
}

protocol QuestionCompleteViewControllable: ViewControllable {}

final class QuestionCompleteRouter: ViewableRouter<QuestionCompleteInteractable, QuestionCompleteViewControllable>, QuestionCompleteRouting {
    
    override init(interactor: QuestionCompleteInteractable, viewController: QuestionCompleteViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
