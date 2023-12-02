//
//  MarkdownContentRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 12/2/23.
//

import RIBs
import MarkdownContentInterface

protocol MarkdownContentInteractable: Interactable {
    var router: MarkdownContentRouting? { get set }
    var listener: MarkdownContentListener? { get set }
}

protocol MarkdownContentViewControllable: ViewControllable {}

final class MarkdownContentRouter: ViewableRouter<MarkdownContentInteractable, MarkdownContentViewControllable>, MarkdownContentRouting {
    
    override init(interactor: MarkdownContentInteractable, viewController: MarkdownContentViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
