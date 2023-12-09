//
//  QuestionInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/9/23.
//

import RIBs
import RxSwift
import QuestionInterface

protocol QuestionRouting: ViewableRouting {}

protocol QuestionPresentable: Presentable {
    var listener: QuestionPresentableListener? { get set }
}

final class QuestionInteractor: PresentableInteractor<QuestionPresentable>, QuestionInteractable, QuestionPresentableListener {
    
    weak var router: QuestionRouting?
    weak var listener: QuestionListener?
    
    override init(presenter: QuestionPresentable) {
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
