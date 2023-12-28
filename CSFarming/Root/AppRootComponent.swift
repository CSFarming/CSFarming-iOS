//
//  AppRootComponent.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import Foundation
import SwiftData
import RIBs
import BaseService
import Archive
import ArchiveService
import ArchiveInterface
import Farming
import FarmingService
import FarmingInterface
import Home
import HomeService
import MarkdownContent
import MarkdownService
import MarkdownContentInterface
import Problem
import ProblemService
import Question
import QuestionService
import QuestionInterface

typealias AppRootComponentDependency = HomeDependency & ArchiveDependency & ProblemDependency & MarkdownContentDependency & QuestionDependency & QuestionCreateDependency & FarmingHomeDependency

final class AppRootComponent: Component<AppRootDependency>, AppRootComponentDependency {
    
    let homeService: HomeServiceInterface
    let markdownService: MarkdownServiceInterface
    let questionService: QuestionServiceInterface
    let farmingService: FarmingServiceInterface
    
    let archiveService: ArchiveServiceInterface = ArchiveService(parser: GitHubRootParser())
    let problemService: ProblemServiceInterface = ProblemService()
    
    lazy var markdownContentBuilder: MarkdownContentBuildable = MarkdownContentBuilder(dependency: self)
    lazy var questionBuilder: QuestionBuildable = QuestionBuilder(dependency: self)
    lazy var questionCreateBuilder: QuestionCreateBuildable = QuestionCreateBuilder(dependency: self)
    lazy var farmingHomeBuilder: FarmingHomeBuildable = FarmingHomeBuilder(dependency: self)
    
    override init(dependency: AppRootDependency) {
        let schema = Schema([ContentElementModel.self, QuestionListModel.self, FarmingElementModel.self, FarmingProblemModel.self])
        let storage = SwiftDataStorage(schema: schema)
        let csCalendar = CSCalendar()
        let farmingRepository = FarmingRepository(storage: storage)
        
        self.homeService = HomeService(
            repository: HomeRepository(storage: storage),
            farmingRepository: farmingRepository
        )
        self.markdownService = MarkdownService(
            repository: MarkdownRepository(storage: storage),
            farmingRepository: farmingRepository,
            calendar: csCalendar
        )
        self.questionService = QuestionService(
            repository: QuestionRepository(storage: storage),
            farmingRepository: farmingRepository,
            calendar: csCalendar
        )
        self.farmingService = FarmingService(
            repository: farmingRepository, 
            calendar: csCalendar
        )
        super.init(dependency: dependency)
    }
    
}
