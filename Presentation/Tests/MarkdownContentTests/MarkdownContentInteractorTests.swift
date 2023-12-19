//
//  MarkdownContentInteractorTests.swift
//  
//
//  Created by 홍성준 on 12/19/23.
//

@testable import MarkdownContent
import XCTest
import Quick
import Nimble
import RIBsTestUtil

final class MarkdownContentInteractorTests: QuickSpec {
    
    override class func spec() {
        var sut: MarkdownContentInteractor!
        var router: MarkdownContentRouterMock!
        var presenter: MarkdownContentPresentableMock!
        var dependency: MarkdownContentInteractorDependencyMock!
        
        describe("MarkdownContentInteractor 테스트") {
            beforeEach {
                presenter = MarkdownContentPresentableMock()
                dependency = MarkdownContentInteractorDependencyMock(title: "title", path: "path", isFromRoot: true)
                sut = MarkdownContentInteractor(presenter: presenter, dependency: dependency)
                router = MarkdownContentRouterMock(interactable: sut)
                sut.router = router
            }
            
            context("Interactor가 Active 되면") {
                beforeEach {
                    sut.activate()
                }
                
                it("최근 방문 기록을 저장한다") {
                    expect { dependency.markdownServiceMock.requestVisitElementCallCount } == 1
                }
            }
        }
    }
    
}
