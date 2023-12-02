//
//  NavigationControllable.swift
//
//
//  Created by 홍성준 on 11/26/23.
//

import UIKit
import RIBs

open class NavigationControllable: ViewControllable {
    
    public let navigationController: UINavigationController
    public var uiviewController: UIViewController {
        navigationController
    }
    
    public init(viewControllable: ViewControllable) {
        let navigationController = SwipeNavigationController(rootViewController: viewControllable.uiviewController)
        navigationController.isNavigationBarHidden = true
        self.navigationController = navigationController
    }
    
}
