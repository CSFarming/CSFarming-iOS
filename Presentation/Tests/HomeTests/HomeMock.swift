//
//  HomeMock.swift
//
//
//  Created by 홍성준 on 12/19/23.
//

@testable import Home
import RIBs
import RIBsTestUtil
import HomeService
import HomeServiceTestUtil

final class HomePresentableMock: HomePresentable {
    
    var listener: HomePresentableListener?
    
    var updateSectionsSectionsCallCount = 0
    var updateSectionsSectionsSections: [HomeSection]?
    func updateSections(_ sections: [HomeSection]) {
        updateSectionsSectionsCallCount += 1
        updateSectionsSectionsSections = sections
    }
    
}

final class HomeInteractorDependencyMock: HomeInteractorDependency {
    
    var homeService: HomeServiceInterface { homeServiceMock }
    let homeServiceMock: HomeServiceMock
    
    init() {
        self.homeServiceMock = HomeServiceMock()
    }
    
}

final class HomeRouterMock: ViewableRoutingMock, HomeRouting {
    
    init(interactable: Interactable) {
        let viewController = ViewControllerMock()
        super.init(viewControllable: viewController, interactable: interactable)
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
