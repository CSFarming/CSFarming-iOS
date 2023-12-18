//
//  ProblemCreateInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/17/23.
//

import RIBs
import RxSwift

protocol ProblemCreateRouting: ViewableRouting {
    func attachQuestionCreate()
    func detachQuestionCreate()
}

protocol ProblemCreatePresentable: Presentable {
    var listener: ProblemCreatePresentableListener? { get set }
}

protocol ProblemCreateListener: AnyObject {
    func problemCreateDidTapClose()
    func problemCreateDidCreate()
}

final class ProblemCreateInteractor: PresentableInteractor<ProblemCreatePresentable>, ProblemCreateInteractable, ProblemCreatePresentableListener {
    
    weak var router: ProblemCreateRouting?
    weak var listener: ProblemCreateListener?
    
    override init(presenter: ProblemCreatePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapClose() {
        listener?.problemCreateDidTapClose()
    }
    
    func didTapQuestion() {
        router?.attachQuestionCreate()
    }
    
    // MARK: - QuestionCreate
    
    func questionCreateDidTapClose() {
        router?.detachQuestionCreate()
    }
    
    func questionCreateDidCreate() {
        listener?.problemCreateDidCreate()
    }
    
}
