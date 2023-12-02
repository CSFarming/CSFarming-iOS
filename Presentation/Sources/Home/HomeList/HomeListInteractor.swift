//
//  HomeListInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/2/23.
//

import RIBs
import RxSwift
import HomeService

protocol HomeListRouting: ViewableRouting {}

protocol HomeListPresentable: Presentable {
    var listener: HomeListPresentableListener? { get set }
}

protocol HomeListListener: AnyObject {
    func homeListDidTapClose()
}

protocol HomeListInteractorDependency: AnyObject {
    var homeService: HomeServiceInterface { get }
    var path: String { get }
}

final class HomeListInteractor: PresentableInteractor<HomeListPresentable>, HomeListInteractable, HomeListPresentableListener {
    
    weak var router: HomeListRouting?
    weak var listener: HomeListListener?
    
    private let dependency: HomeListInteractorDependency
    
    init(
        presenter: HomeListPresentable,
        dependency: HomeListInteractorDependency
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
    
    func didTapClose() {
        listener?.homeListDidTapClose()
    }
    
}
