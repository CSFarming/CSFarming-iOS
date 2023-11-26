//
//  AppComponent.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import RIBs

final class AppComponent: Component<EmptyComponent>, AppRootDependency {
    
    init() {
        super.init(dependency: EmptyComponent())
    }
    
}
