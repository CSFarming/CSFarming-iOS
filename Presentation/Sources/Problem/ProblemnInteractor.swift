//
//  ProblemInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import RIBs
import RxSwift
import ProblemInterface

protocol ProblemRouting: ViewableRouting {}

protocol ProblemPresentable: Presentable {
    var listener: ProblemPresentableListener? { get set }
}

final class ProblemInteractor: PresentableInteractor<ProblemPresentable>, ProblemInteractable, ProblemPresentableListener {
    
    weak var router: ProblemRouting?
    weak var listener: ProblemListener?
    
    override init(presenter: ProblemPresentable) {
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
