//
//  QuestionCompleteInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/15/23.
//

import RIBs
import RxSwift

protocol QuestionCompleteRouting: ViewableRouting {}

protocol QuestionCompletePresentable: Presentable {
    var listener: QuestionCompletePresentableListener? { get set }
}

protocol QuestionCompleteListener: AnyObject {}

protocol QuestionCompleteInteractorDependency: AnyObject {
    var questions: [String] { get }
    var answers: [QuestionAnswerType] { get }
}

final class QuestionCompleteInteractor: PresentableInteractor<QuestionCompletePresentable>, QuestionCompleteInteractable, QuestionCompletePresentableListener {
    
    weak var router: QuestionCompleteRouting?
    weak var listener: QuestionCompleteListener?
    
    private let dependency: QuestionCompleteInteractorDependency
    
    init(
        presenter: QuestionCompletePresentable,
        dependency: QuestionCompleteInteractorDependency
    ) {
        self.dependency = dependency
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
