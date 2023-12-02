//
//  AppRootComponent.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import RIBs
import Home
import Problem
import HomeService

final class AppRootComponent: Component<AppRootDependency>, HomeDependency, ProblemDependency {
    
    let homeService: HomeServiceInterface = HomeService(parser: HomeParser())
    
}
