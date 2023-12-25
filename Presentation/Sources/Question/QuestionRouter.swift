//
//  QuestionRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 12/9/23.
//

import RIBs
import RIBsUtil
import QuestionInterface
import QuestionService

protocol QuestionInteractable: Interactable, QuestionCompleteListener {
    var router: QuestionRouting? { get set }
    var listener: QuestionListener? { get set }
}

protocol QuestionViewControllable: ViewControllable {}

final class QuestionRouter: ViewableRouter<QuestionInteractable, QuestionViewControllable>, QuestionRouting {
    
    private let questionCompleteBuilder: QuestionCompleteBuildable
    private var questionCompleteRouting: ViewableRouting?
    
    init(
        interactor: QuestionInteractable,
        viewController: QuestionViewControllable,
        questionCompleteBuilder: QuestionCompleteBuildable
    ) {
        self.questionCompleteBuilder = questionCompleteBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachQuestionComplete(title: String, category: String, questions: [Question], answers: [QuestionAnswerType]) {
        guard questionCompleteRouting == nil else { return }
        let router = questionCompleteBuilder.build(withListener: interactor, title: title, category: category, questions: questions, answers: answers)
        pushRouter(router, animated: true)
        questionCompleteRouting = router
    }
    
    func detachQuestionComplete() {
        guard let router = questionCompleteRouting else { return }
        popRouter(router, animated: true)
        questionCompleteRouting = nil
    }
    
}
