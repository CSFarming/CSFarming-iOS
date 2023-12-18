//
//  QuestionCreateCompleteInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/18/23.
//

import RIBs
import RxSwift

protocol QuestionCreateCompleteRouting: ViewableRouting {}

protocol QuestionCreateCompletePresentable: Presentable {
    var listener: QuestionCreateCompletePresentableListener? { get set }
}

protocol QuestionCreateCompleteListener: AnyObject {}

final class QuestionCreateCompleteInteractor: PresentableInteractor<QuestionCreateCompletePresentable>, QuestionCreateCompleteInteractable, QuestionCreateCompletePresentableListener {
    
    weak var router: QuestionCreateCompleteRouting?
    weak var listener: QuestionCreateCompleteListener?
    
    override init(presenter: QuestionCreateCompletePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
}
