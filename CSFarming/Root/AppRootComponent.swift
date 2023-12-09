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
import BaseService
import HomeService
import ArchiveService
import ProblemService
import MarkdownService
import MarkdownContent
import MarkdownContentInterface
import QuestionService
import QuestionInterface
import Question
import ArchiveInterface

final class AppRootComponent: Component<AppRootDependency>, HomeDependency, ArchiveDependency, ProblemDependency, MarkdownContentDependency, QuestionDependency {
    
    let homeService: HomeServiceInterface = HomeService(repository: HomeRepository())
    let archiveService: ArchiveServiceInterface = ArchiveService(parser: GitHubRootParser())
    let markdownService: MarkdownServiceInterface = MarkdownService(repository: MarkdownRepository())
    let problemService: ProblemServiceInterface = ProblemService()
    let questionService: QuestionServiceInterface = QuestionService()
    
    lazy var markdownContentBuilder: MarkdownContentBuildable = MarkdownContentBuilder(dependency: self)
    lazy var questionBuilder: QuestionBuildable = QuestionBuilder(dependency: self)
    
}
