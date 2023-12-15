//
//  QuestionCompleteInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/15/23.
//

import RIBs
import RxSwift

protocol QuestionCompleteRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol QuestionCompletePresentable: Presentable {
    var listener: QuestionCompletePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol QuestionCompleteListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class QuestionCompleteInteractor: PresentableInteractor<QuestionCompletePresentable>, QuestionCompleteInteractable, QuestionCompletePresentableListener {

    weak var router: QuestionCompleteRouting?
    weak var listener: QuestionCompleteListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: QuestionCompletePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
