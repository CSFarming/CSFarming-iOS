//
//  AppRootComponent.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import SwiftData
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

typealias AppRootComponentDependency = HomeDependency & ArchiveDependency & ProblemDependency & MarkdownContentDependency & QuestionDependency & QuestionCreateDependency

final class AppRootComponent: Component<AppRootDependency>, AppRootComponentDependency {
    
    let homeService: HomeServiceInterface
    let markdownService: MarkdownServiceInterface
    let questionService: QuestionServiceInterface
    
    let archiveService: ArchiveServiceInterface = ArchiveService(parser: GitHubRootParser())
    let problemService: ProblemServiceInterface = ProblemService()
    
    lazy var markdownContentBuilder: MarkdownContentBuildable = MarkdownContentBuilder(dependency: self)
    lazy var questionBuilder: QuestionBuildable = QuestionBuilder(dependency: self)
    lazy var questionCreateBuilder: QuestionCreateBuildable = QuestionCreateBuilder(dependency: self)
    
    
    override init(dependency: AppRootDependency) {
        let schema = Schema([ContentElementModel.self, QuestionListModel.self])
        let storage = SwiftDataStorage(schema: schema)
        
        self.homeService = HomeService(repository: HomeRepository(storage: storage))
        self.markdownService = MarkdownService(repository: MarkdownRepository(storage: storage))
        self.questionService = QuestionService(repository: QuestionRepository(storage: storage))
        super.init(dependency: dependency)
    }
    
}
