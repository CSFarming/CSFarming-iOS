//
//  ArchiveMock.swift
//
//
//  Created by 홍성준 on 12/19/23.
//

@testable import Archive
import RIBs
import RIBsTestUtil
import ArchiveService
import ArchiveServiceTestUtil

final class ArchivePresentableMock: ArchivePresentable {
    
    var listener: ArchivePresentableListener?
    
    var updateModelsModelsCallCount = 0
    var updateModelsModels: [ArchiveCellModel]?
    func updateModels(_ models: [ArchiveCellModel]) {
        updateModelsModelsCallCount += 1
        updateModelsModels = models
    }
    
}

final class ArchiveInteractorDependencyMock: ArchiveInteractorDependency {
    
    var archiveServiceMock: ArchiveServiceMock
    var archiveService: ArchiveServiceInterface { archiveServiceMock }
    
    init() {
        self.archiveServiceMock = ArchiveServiceMock()
    }
    
}

final class ArchiveRouterMock: ViewableRoutingMock, ArchiveRouting {
    
    var viewControllableMock: ViewControllerMock
    
    init(interactable: Interactable) {
        self.viewControllableMock = ViewControllerMock()
        super.init(viewControllable: viewControllableMock, interactable: interactable)
    }
    
    var attachArchiveListTitlePathCallCount = 0
    var attachArchiveListTitlePathTitle: String?
    var attachArchiveListTitlePathPath: String?
    func attachArchiveList(title: String, path: String) {
        attachArchiveListTitlePathCallCount += 1
        attachArchiveListTitlePathTitle = title
        attachArchiveListTitlePathPath = path
    }
    
    var detachArchiveListCallCount = 0
    func detachArchiveList() {
        detachArchiveListCallCount += 1
    }
    
    var attachMarkdownContentTitlePathCallCount = 0
    var attachMarkdownContentTitlePathTitle: String?
    var attachMarkdownContentTitlePathPath: String?
    func attachMarkdownContent(title: String, path: String) {
        attachMarkdownContentTitlePathCallCount += 1
        attachMarkdownContentTitlePathTitle = title
        attachMarkdownContentTitlePathPath = path
    }
    
    var detachMarkdownContentCallCount = 0
    func detachMarkdownContent() {
        detachMarkdownContentCallCount += 1
    }
    
}
