//
//  QuestionCreateRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 12/17/23.
//

import RIBs
import RIBsUtil
import QuestionInterface
import QuestionService

protocol QuestionCreateInteractable: Interactable, QuestionCreateCompleteListener {
    var router: QuestionCreateRouting? { get set }
    var listener: QuestionCreateListener? { get set }
}

protocol QuestionCreateViewControllable: ViewControllable {}

final class QuestionCreateRouter: ViewableRouter<QuestionCreateInteractable, QuestionCreateViewControllable>, QuestionCreateRouting {
    
    private let completeBuilder: QuestionCreateCompleteBuildable
    private var completeRouter: ViewableRouting?
    
    init(
        interactor: QuestionCreateInteractable,
        viewController: QuestionCreateViewControllable,
        completeBuilder: QuestionCreateCompleteBuildable
    ) {
        self.completeBuilder = completeBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachComplete(title: String, subtitle: String, questions: [Question]) {
        guard completeRouter == nil else { return }
        let router = completeBuilder.build(withListener: interactor, title: title, subtitle: subtitle, questions: questions)
        pushRouter(router, animated: true)
        completeRouter = router
    }
    
    func detachComplete() {
        guard let router = completeRouter else { return }
        popRouter(router, animated: true)
        completeRouter = nil
    }
    
}
