//
//  AppRootRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import RIBs

protocol AppRootInteractable: Interactable {
    var router: AppRootRouting? { get set }
}

protocol AppRootViewControllable: ViewControllable {}

final class AppRootRouter: LaunchRouter<AppRootInteractable, AppRootViewControllable>, AppRootRouting {
    
    override init(interactor: AppRootInteractable, viewController: AppRootViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
