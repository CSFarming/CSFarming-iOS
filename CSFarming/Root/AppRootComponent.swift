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
import MarkdownService
import MarkdownContent
import MarkdownContentInterface

final class AppRootComponent: Component<AppRootDependency>, HomeDependency, ProblemDependency, MarkdownContentDependency {
    
    let homeService: HomeServiceInterface = HomeService(parser: HomeParser())
    let markdownService: MarkdownServiceInterface = MarkdownService()
    
    lazy var markdownContentBuilder: MarkdownContentBuildable = MarkdownContentBuilder(dependency: self)
    
}
