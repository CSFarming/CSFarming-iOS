//
//  HomeFarmingInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/20/23.
//

import RIBs
import RxSwift

protocol HomeFarmingRouting: ViewableRouting {}

protocol HomeFarmingPresentable: Presentable {
    var listener: HomeFarmingPresentableListener? { get set }
}

protocol HomeFarmingListener: AnyObject {}

final class HomeFarmingInteractor: PresentableInteractor<HomeFarmingPresentable>, HomeFarmingInteractable, HomeFarmingPresentableListener {
    
    weak var router: HomeFarmingRouting?
    weak var listener: HomeFarmingListener?
    
    override init(presenter: HomeFarmingPresentable) {
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
