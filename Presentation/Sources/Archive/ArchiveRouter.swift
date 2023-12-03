//
//  ArchiveRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 12/3/23.
//

import RIBs
import ArchiveInterface

protocol ArchiveInteractable: Interactable {
    var router: ArchiveRouting? { get set }
    var listener: ArchiveListener? { get set }
}

protocol ArchiveViewControllable: ViewControllable {}

final class ArchiveRouter: ViewableRouter<ArchiveInteractable, ArchiveViewControllable>, ArchiveRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ArchiveInteractable, viewController: ArchiveViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
