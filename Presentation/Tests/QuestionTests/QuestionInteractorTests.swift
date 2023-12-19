//
//  QuestionInteractorTests.swift
//
//
//  Created by 홍성준 on 12/19/23.
//

@testable import Question
import XCTest
import Quick
import Nimble
import RIBsTestUtil
import QuestionService

final class QuestionInteractorTests: AsyncSpec {
    
    override class func spec() {
        var sut: QuestionInteractor!
        var presenter: QuestionPresentableMock!
        var dependency: QuestionInteractorDependencyMock!
        var router: QuestionRouterMock!
        
        describe("QuestionInteractor 테스트") {
            beforeEach {
                presenter = QuestionPresentableMock()
                dependency = QuestionInteractorDependencyMock(title: "title", directory: "directory")
                sut = QuestionInteractor(presenter: presenter, dependency: dependency)
                router = QuestionRouterMock(interactable: sut)
                sut.router = router
            }
            
            context("Interactor가 active 되면") {
                beforeEach {
                    sut.activate()
                }
                
                it("디렉토리를 통해 Questions을 불러온다") {
                    expect { dependency.questionServiceMock.requestQuestionsDirectoryCallCount } == 1
                    expect { dependency.questionServiceMock.requestQuestionsDirectoryDirectory } == "directory"
                }
            }
            
            context("질문들이 주어지고") {
                let questionList = QuestionList(
                    id: 1,
                    questions: [
                        .init(question: "질문1", answer: "답변1"),
                        .init(question: "질문2", answer: "답변2"),
                        .init(question: "질문3", answer: "답변3")
                    ])
                
                beforeEach {
                    dependency.questionServiceMock.requestQuestionsDirectoryResult = questionList
                    sut.activate()
                    _ = try await dependency.questionServiceMock.requestQuestions(directory: "").value
                }
                
                context("질문보다 적게 답변을 제출하면") {
                    beforeEach {
                        sut.didTapOK()
                        sut.didTapPass()
                    }
                    
                    it("완료되지 않는다") {
                        expect { router.attachQuestionCompleteQuestionsAnswersCallCount } == 0
                    }
                }
                
                context("모든 질문에 답변을 제출하면") {
                    beforeEach {
                        sut.didTapOK()
                        sut.didTapPass()
                        sut.didTapOK()
                    }
                    
                    it("완료 화면으로 라우팅 요청을 한다") {
                        expect { router.attachQuestionCompleteQuestionsAnswersCallCount } == 1
                    }
                }
            }
        }
    }
    
}
