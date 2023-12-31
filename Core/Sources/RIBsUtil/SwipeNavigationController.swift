//
//  SwipeNavigationController.swift
//
//
//  Created by 홍성준 on 12/2/23.
//

import UIKit

final class SwipeNavigationController: UINavigationController {
    
    private var isAnimating = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
        self.delegate = self
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        isAnimating = true
        super.pushViewController(viewController, animated: animated)
    }
    
}

extension SwipeNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        isAnimating = false
    }
    
}

extension SwipeNavigationController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1 && !isAnimating
    }
    
}

