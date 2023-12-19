//
//  HomeInteractorTests.swift
//  
//
//  Created by 홍성준 on 12/19/23.
//

@testable import Home
import XCTest
import Quick
import Nimble
import RIBsTestUtil

final class HomeInteractorTests: AsyncSpec {
    
    override class func spec() {
        var sut: HomeInteractor!
        var router: HomeRouterMock!
        var presenter: HomePresentableMock!
        var dependency: HomeInteractorDependencyMock!
        
        describe("HomeInteractor 테스트") {
            beforeEach {
                presenter = HomePresentableMock()
                dependency = HomeInteractorDependencyMock()
                sut = HomeInteractor(
                    presenter: presenter,
                    dependency: dependency
                )
                router = HomeRouterMock(interactable: sut)
                sut.router = router
            }
            
            context("Interactor가 Active 되면") {
                beforeEach {
                    sut.activate()
                }
                
                it("최근 방문 기록을 불러온다") {
                    expect { dependency.homeServiceMock.requestVisitHistoryCallCount } == 1
                }
            }
            
            context("ViewAppear이 1번 호출되면") {
                beforeEach {
                    sut.viewWillAppear()
                }
                
                it("최근 방문 기록을 불러오지 않는다") {
                    expect { dependency.homeServiceMock.requestVisitHistoryCallCount } == 0
                }
            }
            
            context("ViewAppear이 n번 호출되면") {
                let n = 5
                beforeEach {
                    (0..<n).forEach { _ in
                        sut.viewWillAppear()
                    }
                }
                
                it("최근 방문 기록을 n-1번 불러온다") {
                    expect { dependency.homeServiceMock.requestVisitHistoryCallCount } == n - 1
                }
            }
        }
    }
    
}
