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

protocol ProblemInteractable: Interactable, QuestionListener {
    var router: ProblemRouting? { get set }
    var listener: ProblemListener? { get set }
}

protocol ProblemViewControllable: ViewControllable {}

final class ProblemRouter: ViewableRouter<ProblemInteractable, ProblemViewControllable>, ProblemRouting {
    
    private let questionBuilder: QuestionBuildable
    private var questionRouting: ViewableRouting?
    
    init(
        interactor: ProblemInteractable,
        viewController: ProblemViewControllable,
        questionBuilder: QuestionBuildable
    ) {
        self.questionBuilder = questionBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachQuestion(directory: String) {
        guard questionRouting == nil else { return }
        let router = questionBuilder.build(withListener: interactor, directory: directory)
        pushRouter(router, animated: true)
        questionRouting = router
    }
    
    func detachQuestion() {
        guard let router = questionRouting else { return }
        popRouter(router, animated: true)
        questionRouting = nil
    }
    
}
