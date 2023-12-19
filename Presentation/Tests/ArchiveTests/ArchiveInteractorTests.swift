//
//  ArchiveInteractorTests.swift
//
//
//  Created by 홍성준 on 12/19/23.
//

@testable import Archive
import XCTest
import Quick
import Nimble

final class ArchiveInteractorTests: AsyncSpec {
    
    override class func spec() {
        var sut: ArchiveInteractor!
        var router: ArchiveRouterMock!
        var presenter: ArchivePresentableMock!
        var dependency: ArchiveInteractorDependencyMock!
        
        describe("ArchiveInteractor 테스트") {
            beforeEach {
                presenter = ArchivePresentableMock()
                dependency = ArchiveInteractorDependencyMock()
                sut = ArchiveInteractor(
                    presenter: presenter,
                    dependency: dependency
                )
                router = ArchiveRouterMock(interactable: sut)
                sut.router = router
            }
            
            context("Interactor가 Active 되면") {
                beforeEach {
                    sut.activate()
                }
                
                it("ArchiveService의 requestElements를 호출한다") {
                    expect { dependency.archiveServiceMock.requestElementsCallCount }.to(equal(1))
                }
            }
            
            context("디렉토리, md 파일이 주어지고") {
                beforeEach {
                    dependency.archiveServiceMock.requestElementsResult = [
                        .init(title: "Markdown.md", path: "path1"),
                        .init(title: "Directory", path: "path2")
                    ]
                    sut.activate()
                    _ = try await dependency.archiveServiceMock.requestElements().value
                }
                
                context("md 파일이 선택되면") {
                    beforeEach {
                        sut.didSelect(at: .init(row: 0, section: 0))
                    }
                    
                    it("MarkdownContent로 라우팅한다") {
                        expect { router.attachMarkdownContentTitlePathCallCount } == 1
                        expect { router.attachMarkdownContentTitlePathTitle } == "Markdown.md"
                        expect { router.attachMarkdownContentTitlePathPath } == "path1"
                    }
                }
                
                context("디렉토리가 선택되면") {
                    beforeEach {
                        sut.didSelect(at: .init(row: 1, section: 0))
                    }
                    
                    it("ArchiveList로 라우팅한다") {
                        expect { router.attachArchiveListTitlePathCallCount } == 1
                        expect { router.attachArchiveListTitlePathTitle } == "Directory"
                        expect { router.attachArchiveListTitlePathPath } == "path2"
                    }
                }
            }
        }
    }
    
}
