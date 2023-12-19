//
//  ProblemMock.swift
//
//
//  Created by 홍성준 on 12/19/23.
//

@testable import Problem
import RIBs
import RIBsTestUtil
import ProblemService
import ProblemServiceTestUtil
import QuestionService
import QuestionServiceTestUtil

final class ProblemPresentableMock: ProblemPresentable {
    var listener: ProblemPresentableListener?
    
    var updateSectionsSectionsCallCount = 0
    var updateSectionsSectionsSections: [ProblemSection]?
    func updateSections(_ sections: [ProblemSection]) {
        updateSectionsSectionsCallCount += 1
        updateSectionsSectionsSections = sections
    }
    
}

final class ProblemInteractorDependencyMock: ProblemInteractorDependency {
    
    var problemService: ProblemServiceInterface { problmeServiceMock }
    let problmeServiceMock: ProblemServiceMock
    var questionService: QuestionServiceInterface { questionServiceMock }
    let questionServiceMock: QuestionServiceMock
    
    init() {
        self.problmeServiceMock = ProblemServiceMock()
        self.questionServiceMock = QuestionServiceMock()
    }
    
}

final class ProblemRouterMock: ViewableRoutingMock, ProblemRouting {
    
    init(interactable: Interactable) {
        super.init(viewControllable: ViewControllerMock(), interactable: interactable)
    }
    
    var attachQuestionTitleDirectoryCallCount = 0
    var attachQuestionTitleDirectoryTitle: String?
    var attachQuestionTitleDirectoryDirectory: String?
    func attachQuestion(title: String, directory: String) {
        attachQuestionTitleDirectoryCallCount += 1
        attachQuestionTitleDirectoryTitle = title
        attachQuestionTitleDirectoryDirectory = directory
    }
    
    var detachQuestionCallCount = 0
    func detachQuestion() {
        detachQuestionCallCount += 1
    }
    
    var attachProblemTitleDirectoryCallCount = 0
    var attachProblemTitleDirectoryTitle: String?
    var attachProblemTitleDirectoryDirectory: String?
    func attachProblem(title: String, directory: String) {
        attachProblemTitleDirectoryCallCount += 1
        attachProblemTitleDirectoryTitle = title
        attachProblemTitleDirectoryDirectory = directory
    }
    
    var detachProblemCallCount = 0
    func detachProblem() {
        detachProblemCallCount += 1
    }
    
    var attachProblemCreateCallCount = 0
    func attachProblemCreate() {
        attachProblemCreateCallCount += 1
    }
    
    var detachProblemCreateCallCount = 0
    func detachProblemCreate() {
        detachProblemCreateCallCount += 1
    }
    
}
