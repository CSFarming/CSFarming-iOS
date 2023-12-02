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

protocol HomeRouting: ViewableRouting {
    func attachHomeList(path: String)
    func detachHomeList()
}

protocol HomePresentable: Presentable {
    var listener: HomePresentableListener? { get set }
    func updateSections(_ sections: [HomeSection])
}

protocol HomeInteractorDependency: AnyObject {
    var homeService: HomeServiceInterface { get }
}

final class HomeInteractor: PresentableInteractor<HomePresentable>, HomeInteractable, HomePresentableListener {
    
    weak var router: HomeRouting?
    weak var listener: HomeListener?
    
    private var homeElements: [HomeElement] = []
    
    private let dependency: HomeInteractorDependency
    private let disposeBag = DisposeBag()
    
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
        fetchHomeList()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didSelect(at indexPath: IndexPath) {
        guard let element = homeElements[safe: indexPath.row] else { return }
        router?.attachHomeList(path: element.path)
    }
    
    func homeListDidTapClose() {
        router?.detachHomeList()
    }
    
    private func fetchHomeList() {
        dependency.homeService
            .requestElements()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                with: self,
                onSuccess: { this, elements in
                    this.performAfterHomeList(elements)
                },
                onFailure: { this, error in
                    print(error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func performAfterHomeList(_ elements: [HomeElement]) {
        self.homeElements = elements
        let models = elements.map { element -> HomeItem in
            return .recentPost(.init(
                title: element.title,
                type: element.fileType == .directory ? .folder : .file
            ))
        }
        presenter.updateSections([.recentPost(models)])
    }
    
}
