//
//  ProblemListRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 12/9/23.
//

import RIBs
import RIBsUtil
import QuestionInterface

protocol ProblemListInteractable: Interactable, ProblemListListener, QuestionListener {
    var router: ProblemListRouting? { get set }
    var listener: ProblemListListener? { get set }
}

protocol ProblemListViewControllable: ViewControllable {}

final class ProblemListRouter: ViewableRouter<ProblemListInteractable, ProblemListViewControllable>, ProblemListRouting {
    
    private let problemBuilder: ProblemListBuildable
    private var problemRouting: ViewableRouting?
    
    private let questionBuilder: QuestionBuildable
    private var questionRouting: ViewableRouting?
    
    init(
        interactor: ProblemListInteractable,
        viewController: ProblemListViewControllable,
        problemBuilder: ProblemListBuildable,
        questionBuilder: QuestionBuildable
    ) {
        self.problemBuilder = problemBuilder
        self.questionBuilder = questionBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachProblemList(title: String, directory: String) {
        guard problemRouting == nil else { return }
        let router = problemBuilder.build(withListener: interactor, title: title, directory: directory)
        pushRouter(router, animated: true)
        problemRouting = router
    }
    
    func detachProblemList() {
        guard let router = problemRouting else { return }
        popRouter(router, animated: true)
        problemRouting = nil
    }
    
    func attachQuestion(title: String, directory: String) {
        guard questionRouting == nil else { return }
        let router = questionBuilder.build(withListener: interactor, title: title, directory: directory)
        pushRouter(router, animated: true)
        questionRouting = router
    }
    
    func detachQuestion() {
        guard let router = questionRouting else { return }
        popRouter(router, animated: true)
        questionRouting = nil
    }
    
}
