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

protocol ProblemInteractable: Interactable, QuestionListener, ProblemListListener, ProblemCreateListener {
    var router: ProblemRouting? { get set }
    var listener: ProblemListener? { get set }
}

protocol ProblemViewControllable: ViewControllable {}

final class ProblemRouter: ViewableRouter<ProblemInteractable, ProblemViewControllable>, ProblemRouting {
    
    private let questionBuilder: QuestionBuildable
    private var questionRouting: ViewableRouting?
    
    private let problemBuilder: ProblemListBuildable
    private var problemRouting: ViewableRouting?
    
    private let problemCreateBuilder: ProblemCreateBuildable
    private var problemCreateRouting: ViewableRouting?
    
    init(
        interactor: ProblemInteractable,
        viewController: ProblemViewControllable,
        questionBuilder: QuestionBuildable,
        problemBuilder: ProblemListBuildable,
        problemCreateBuilder: ProblemCreateBuildable
    ) {
        self.questionBuilder = questionBuilder
        self.problemBuilder = problemBuilder
        self.problemCreateBuilder = problemCreateBuilder
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
    
    func attachProblemCreate() {
        guard problemCreateRouting == nil else { return }
        let router = problemCreateBuilder.build(withListener: interactor)
        viewController.present(NavigationControllable(viewControllable: router.viewControllable), animated: true, isFullScreen: true)
        attachChild(router)
        problemCreateRouting = router
    }
    
    func detachProblemCreate() {
        guard let router = problemCreateRouting else { return }
        dismiss(router, animated: true)
        problemCreateRouting = nil
    }
    
}
