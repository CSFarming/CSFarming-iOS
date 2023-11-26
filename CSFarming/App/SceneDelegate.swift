//
//  SceneDelegate.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import UIKit
import RIBs

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private var launchRouter: LaunchRouting?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        self.window = window
        let router = AppRootBuilder(dependency: AppComponent()).build()
        launchRouter = router
        router.launch(from: window)
    }
    
}

