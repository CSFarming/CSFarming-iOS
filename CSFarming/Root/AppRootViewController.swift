//
//  AppRootViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import RIBs
import RxSwift
import UIKit

protocol AppRootPresentableListener: AnyObject {}

final class AppRootViewController: UITabBarController, AppRootPresentable, AppRootViewControllable {
    
    weak var listener: AppRootPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .csBlue1
    }
    
    func setViewControllers(_ viewControllables: [ViewControllable]) {
        super.setViewControllers(viewControllables.map(\.uiviewController), animated: false)
    }
    
}
