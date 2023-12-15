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

protocol QuestionCompleteViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class QuestionCompleteRouter: ViewableRouter<QuestionCompleteInteractable, QuestionCompleteViewControllable>, QuestionCompleteRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: QuestionCompleteInteractable, viewController: QuestionCompleteViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
