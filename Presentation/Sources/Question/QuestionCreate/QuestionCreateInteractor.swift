//
//  QuestionCreateInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/17/23.
//

import RIBs
import RxSwift
import QuestionInterface

protocol QuestionCreateRouting: ViewableRouting {}

protocol QuestionCreatePresentable: Presentable {
    var listener: QuestionCreatePresentableListener? { get set }
}

final class QuestionCreateInteractor: PresentableInteractor<QuestionCreatePresentable>, QuestionCreateInteractable, QuestionCreatePresentableListener {
    
    weak var router: QuestionCreateRouting?
    weak var listener: QuestionCreateListener?
    
    override init(presenter: QuestionCreatePresentable) {
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
