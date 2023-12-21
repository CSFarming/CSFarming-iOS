//
//  FarmingHomeInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/21/23.
//

import RIBs
import RxSwift
import FarmingInterface

protocol FarmingHomeRouting: ViewableRouting {}

protocol FarmingHomePresentable: Presentable {
    var listener: FarmingHomePresentableListener? { get set }
}

final class FarmingHomeInteractor: PresentableInteractor<FarmingHomePresentable>, FarmingHomeInteractable, FarmingHomePresentableListener {
    
    weak var router: FarmingHomeRouting?
    weak var listener: FarmingHomeListener?
    
    override init(presenter: FarmingHomePresentable) {
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
