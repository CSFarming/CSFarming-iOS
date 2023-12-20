//
//  HomeRecentInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/20/23.
//

import RIBs
import RxSwift

protocol HomeRecentRouting: ViewableRouting {}

protocol HomeRecentPresentable: Presentable {
    var listener: HomeRecentPresentableListener? { get set }
}

protocol HomeRecentListener: AnyObject {}

final class HomeRecentInteractor: PresentableInteractor<HomeRecentPresentable>, HomeRecentInteractable, HomeRecentPresentableListener {
    
    weak var router: HomeRecentRouting?
    weak var listener: HomeRecentListener?
    
    override init(presenter: HomeRecentPresentable) {
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
