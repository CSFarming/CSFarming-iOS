//
//  FarmingQuestionInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/23/23.
//

import RIBs
import RxSwift
import FarmingService

protocol FarmingQuestionRouting: ViewableRouting {}

protocol FarmingQuestionPresentable: Presentable {
    var listener: FarmingQuestionPresentableListener? { get set }
}

protocol FarmingQuestionListener: AnyObject {}

protocol FarmingQuestionInteractorDependency: AnyObject {
    var element: FarmingProblemElement { get }
}

final class FarmingQuestionInteractor: PresentableInteractor<FarmingQuestionPresentable>, FarmingQuestionInteractable, FarmingQuestionPresentableListener {
    
    weak var router: FarmingQuestionRouting?
    weak var listener: FarmingQuestionListener?
    
    private let depenedency: FarmingQuestionInteractorDependency
    
    init(
        presenter: FarmingQuestionPresentable,
        depenedency: FarmingQuestionInteractorDependency
    ) {
        self.depenedency = depenedency
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
