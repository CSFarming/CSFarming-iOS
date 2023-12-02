//
//  Router+ViewControllable.swift
//
//
//  Created by 홍성준 on 12/2/23.
//

import UIKit
import RIBs

public extension ViewableRouting {
    
    func present(
        _ router: ViewableRouting,
        animated: Bool, 
        isFullScreen: Bool = false,
        completion: (() -> Void)? = nil
    ) {
        viewControllable.present(
            router.viewControllable,
            animated: animated,
            isFullScreen: isFullScreen,
            completion: completion
        )
        attachChild(router)
    }
    
    func pushRouter(_ router: ViewableRouting, animated: Bool) {
        viewControllable.pushViewController(router.viewControllable, animated: animated)
        attachChild(router)
    }
    
    func setRouters(_ routers: [ViewableRouting], animated: Bool) {
        viewControllable.setViewControllers(routers.map(\.viewControllable), animated: animated)
        routers.forEach(attachChild)
    }
    
    func dismiss(_ router: ViewableRouting, animated: Bool, completion: (() -> Void)? = nil) {
        viewControllable.dismiss(animated: animated, completion: completion)
        detachChild(router)
    }
    
    func popRouter(_ router: ViewableRouting, animated: Bool) {
        viewControllable.popViewController(viewControllable: router.viewControllable, animated: animated)
        detachChild(router)
    }
    
}
