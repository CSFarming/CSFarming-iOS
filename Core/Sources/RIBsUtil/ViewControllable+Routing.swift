//
//  ViewControllable+Routing.swift
//
//
//  Created by 홍성준 on 11/26/23.
//

import UIKit
import RIBs

public extension ViewControllable {
    
    func present(
        _ viewControllable: ViewControllable,
        animated: Bool,
        isFullScreen: Bool = false,
        completion: (() -> Void)? = nil
    ) {
        if isFullScreen {
            viewControllable.uiviewController.modalPresentationStyle = .overFullScreen
        }
        uiviewController.present(viewControllable.uiviewController, animated: animated, completion: completion)
    }
    
    func pushViewController(_ viewControllable: ViewControllable, animated: Bool) {
        viewControllable.uiviewController.hidesBottomBarWhenPushed = true
        if let navigationController = uiviewController as? UINavigationController {
            navigationController.pushViewController(viewControllable.uiviewController, animated: animated)
        } else {
            uiviewController.navigationController?.pushViewController(viewControllable.uiviewController, animated: animated)
        }
    }
    
    func setViewControllers(_ viewControllables: [ViewControllable], animated: Bool) {
        if let navigationController = uiviewController as? UINavigationController {
            navigationController.setViewControllers(viewControllables.map(\.uiviewController), animated: animated)
        } else {
            uiviewController.navigationController?.setViewControllers(viewControllables.map(\.uiviewController), animated: animated)
        }
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        uiviewController.resign()
        uiviewController.dismiss(animated: animated, completion: completion)
    }
    
    func popViewController(animated: Bool) {
        if let navigationController = uiviewController as? UINavigationController {
            navigationController.topViewController?.resign()
            navigationController.popViewController(animated: animated)
        } else {
            uiviewController.navigationController?.topViewController?.resign()
            uiviewController.navigationController?.popViewController(animated: animated)
        }
    }
    
    func popViewController(viewControllable: ViewControllable, animated: Bool) {
        let navigationController = uiviewController as? UINavigationController ?? uiviewController.navigationController
        
        if navigationController?.topViewController == viewControllable.uiviewController {
            popViewController(animated: animated)
        }
    }
    
}


private extension UIViewController {
    
    func resign() {
        view.endEditing(true)
    }
    
}
