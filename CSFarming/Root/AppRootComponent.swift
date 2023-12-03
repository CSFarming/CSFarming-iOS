//
//  AppRootComponent.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import RIBs
import Home
import Archive
import Problem
import HomeService
import MarkdownService
import MarkdownContent
import MarkdownContentInterface
import ArchiveInterface

final class AppRootComponent: Component<AppRootDependency>, HomeDependency, ArchiveDependency, ProblemDependency, MarkdownContentDependency {
    
    let homeService: HomeServiceInterface = HomeService(repository: HomeRepository(), parser: HomeParser())
    let markdownService: MarkdownServiceInterface = MarkdownService(repository: MarkdownRepository())
    
    lazy var markdownContentBuilder: MarkdownContentBuildable = MarkdownContentBuilder(dependency: self)
    
}
