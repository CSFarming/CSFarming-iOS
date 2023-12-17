//
//  ProblemCreateRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 12/17/23.
//

import RIBs
import RIBsUtil
import QuestionInterface

protocol ProblemCreateInteractable: Interactable, QuestionCreateListener {
    var router: ProblemCreateRouting? { get set }
    var listener: ProblemCreateListener? { get set }
}

protocol ProblemCreateViewControllable: ViewControllable {}

final class ProblemCreateRouter: ViewableRouter<ProblemCreateInteractable, ProblemCreateViewControllable>, ProblemCreateRouting {
    
    private var questionBuilder: QuestionCreateBuildable
    private var questionRouting: ViewableRouting?
    
    init(
        interactor: ProblemCreateInteractable, 
        viewController: ProblemCreateViewControllable, 
        questionBuilder: QuestionCreateBuildable
    ) {
        self.questionBuilder = questionBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachQuestionCreate() {
        guard questionRouting == nil else { return }
        let router = questionBuilder.build(withListener: interactor)
        pushRouter(router, animated: true)
        questionRouting = router
    }
    
    func detachQuestionCreate() {
        guard let router = questionRouting else { return }
        popRouter(router, animated: true)
        questionRouting = nil
    }
    
}
