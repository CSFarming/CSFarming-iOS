//
//  HomeInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import Foundation
import RIBs
import RxSwift
import HomeInterface
import HomeService
import BaseService

protocol HomeRouting: ViewableRouting {
    func attachMarkdownContent(title: String, path: String)
    func detachMarkdownContent()
    
    func attachHomeFarming()
    func attachHomeRecent()
}

protocol HomePresentable: Presentable {
    var listener: HomePresentableListener? { get set }
    func setDashboard(_ viewControllable: ViewControllable)
    func removeDashboard(_ viewControllable: ViewControllable)
}

protocol HomeInteractorDependency: AnyObject {
    var homeService: HomeServiceInterface { get }
}

final class HomeInteractor: PresentableInteractor<HomePresentable>, HomeInteractable, HomePresentableListener {
    
    weak var router: HomeRouting?
    weak var listener: HomeListener?
    
    private let dependency: HomeInteractorDependency
    
    init(
        presenter: HomePresentable,
        dependency: HomeInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        router?.attachHomeFarming()
        router?.attachHomeRecent()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func homeRecentDidTapMarkdownContent(title: String, path: String) {
        router?.attachMarkdownContent(title: title, path: path)
    }
    
    func markdownContentDidTapClose() {
        router?.detachMarkdownContent()
    }
    
}
