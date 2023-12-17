//
//  ProblemRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import RIBs
import ProblemInterface
import QuestionInterface
import RIBsUtil

protocol ProblemInteractable: Interactable, QuestionListener, ProblemListListener {
    var router: ProblemRouting? { get set }
    var listener: ProblemListener? { get set }
}

protocol ProblemViewControllable: ViewControllable {}

final class ProblemRouter: ViewableRouter<ProblemInteractable, ProblemViewControllable>, ProblemRouting {
    
    private let questionBuilder: QuestionBuildable
    private var questionRouting: ViewableRouting?
    
    private let problemBuilder: ProblemListBuildable
    private var problemRouting: ViewableRouting?
    
    init(
        interactor: ProblemInteractable,
        viewController: ProblemViewControllable,
        questionBuilder: QuestionBuildable,
        problemBuilder: ProblemListBuildable
    ) {
        self.questionBuilder = questionBuilder
        self.problemBuilder = problemBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
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
    
    func attachProblem(title: String, directory: String) {
        guard problemRouting == nil else { return }
        let router = problemBuilder.build(withListener: interactor, title: title, directory: directory)
        pushRouter(router, animated: true)
        problemRouting = router
    }
    
    func detachProblem() {
        guard let router = problemRouting else { return }
        popRouter(router, animated: true)
        problemRouting = nil
    }
    
}
