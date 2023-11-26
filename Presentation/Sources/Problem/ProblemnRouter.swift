//
//  ProblemRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import RIBs
import ProblemInterface

protocol ProblemInteractable: Interactable {
    var router: ProblemRouting? { get set }
    var listener: ProblemListener? { get set }
}

protocol ProblemViewControllable: ViewControllable {}

final class ProblemRouter: ViewableRouter<ProblemInteractable, ProblemViewControllable>, ProblemRouting {
    
    override init(interactor: ProblemInteractable, viewController: ProblemViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
