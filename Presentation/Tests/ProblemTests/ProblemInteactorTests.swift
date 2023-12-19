//
//  ProblemInteactorTests.swift
//  
//
//  Created by 홍성준 on 12/19/23.
//

@testable import Problem
import XCTest
import Quick
import Nimble
import RIBsTestUtil

final class ProblemInteactorTests: QuickSpec {
    
    override class func spec() {
        var sut: ProblemInteractor!
        var router: ProblemRouterMock!
        var presenter: ProblemPresentableMock!
        var dependency: ProblemInteractorDependencyMock!
        
        describe("ProblemInteractor 테스트") {
            beforeEach {
                presenter = ProblemPresentableMock()
                dependency = ProblemInteractorDependencyMock()
                sut = ProblemInteractor(presenter: presenter, dependency: dependency)
                router = ProblemRouterMock(interactable: sut)
                sut.router = router
            }
            
            context("Interactor가 active 되면") {
                beforeEach {
                    sut.activate()
                }
                
                it("Elements를 불러온다") {
                    expect { dependency.problmeServiceMock.requestElementsCallCount } == 1
                   
                }
                
                it("LocalQuestions을 불러온다") {
                    expect { dependency.questionServiceMock.requestLocalQuestionsCallCount } == 1
                }
            }
        }
    }
    
}
