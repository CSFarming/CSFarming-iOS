//
//  HomeListInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/2/23.
//

import RIBs
import RxSwift

protocol HomeListRouting: ViewableRouting {}

protocol HomeListPresentable: Presentable {
    var listener: HomeListPresentableListener? { get set }
}

protocol HomeListListener: AnyObject {}

final class HomeListInteractor: PresentableInteractor<HomeListPresentable>, HomeListInteractable, HomeListPresentableListener {
    
    weak var router: HomeListRouting?
    weak var listener: HomeListListener?
    
    override init(presenter: HomeListPresentable) {
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
