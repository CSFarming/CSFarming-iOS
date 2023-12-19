//
//  MarkdownContentMock.swift
//
//
//  Created by 홍성준 on 12/19/23.
//

@testable import MarkdownContent
import RIBs
import RIBsTestUtil
import MarkdownService
import MarkdownServiceTestUtil

final class MarkdownContentPresentableMock: MarkdownContentPresentable {
    
    var listener: MarkdownContentPresentableListener?
    
    var updateMarkdownSourceCallCount = 0
    var updateMarkdownSourceSource: String?
    func updateMarkdown(_ source: String) {
        updateMarkdownSourceCallCount += 1
        updateMarkdownSourceSource = source
    }
    
    var updateTitleTitleCallCount = 0
    var updateTitleTitleTitle: String?
    func updateTitle(_ title: String) {
        updateTitleTitleCallCount += 1
        updateTitleTitleTitle = title
    }
    
}

final class MarkdownContentInteractorDependencyMock: MarkdownContentInteractorDependency {
    
    var markdownService: MarkdownServiceInterface { markdownServiceMock }
    let markdownServiceMock: MarkdownServiceMock
    var title: String
    var path: String
    var isFromRoot: Bool
    
    init(title: String, path: String, isFromRoot: Bool) {
        self.markdownServiceMock = MarkdownServiceMock()
        self.title = title
        self.path = path
        self.isFromRoot = isFromRoot
    }
    
}

final class MarkdownContentRouterMock: ViewableRoutingMock, MarkdownContentRouting {
    init(interactable: Interactable) {
        super.init(viewControllable: ViewControllerMock(), interactable: interactable)
    }
}
