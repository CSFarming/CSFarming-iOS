//
//  HomeInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import RIBs
import RxSwift
import HomeInterface

protocol HomeRouting: ViewableRouting {}

protocol HomePresentable: Presentable {
    var listener: HomePresentableListener? { get set }
}

final class HomeInteractor: PresentableInteractor<HomePresentable>, HomeInteractable, HomePresentableListener {
    
    weak var router: HomeRouting?
    weak var listener: HomeListener?
    
    override init(presenter: HomePresentable) {
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
