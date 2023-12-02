//
//  HomeListInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/2/23.
//

import Foundation
import RIBs
import RxSwift
import HomeService

protocol HomeListRouting: ViewableRouting {
    func attachHomeList(title: String, path: String)
    func detachHomeList()
}

protocol HomeListPresentable: Presentable {
    var listener: HomeListPresentableListener? { get set }
    func updateTitle(_ title: String)
    func updateModels(_ models: [HomeListCellModel])
}

protocol HomeListListener: AnyObject {
    func homeListDidTapClose()
}

protocol HomeListInteractorDependency: AnyObject {
    var homeService: HomeServiceInterface { get }
    var title: String { get }
    var path: String { get }
    var isFromRoot: Bool { get }
}

final class HomeListInteractor: PresentableInteractor<HomeListPresentable>, HomeListInteractable, HomeListPresentableListener, HomeListListener {
    
    weak var router: HomeListRouting?
    weak var listener: HomeListListener?
    
    private var homeElements: [HomeElement] = []
    
    private let dependency: HomeListInteractorDependency
    private let disposeBag = DisposeBag()
    
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
        fetchHomeList()
        presenter.updateTitle(dependency.title)
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapClose() {
        listener?.homeListDidTapClose()
    }
    
    func didTap(at indexPath: IndexPath) {
        guard let element = homeElements[safe: indexPath.row] else { return }
        router?.attachHomeList(title: element.title, path: element.path)
    }
    
    func homeListDidTapClose() {
        router?.detachHomeList()
    }
    
    private func fetchHomeList() {
        let request: Single<[HomeElement]> = {
            if dependency.isFromRoot {
                return dependency.homeService.requestElements(path: dependency.path)
            } else {
                return dependency.homeService.requestElementsWithPrefix(path: dependency.path)
            }
        }()
        
        request
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                with: self,
                onSuccess: { this, elements in
                    this.performAfterHomeList(elements)
                },
                onFailure: { this, error in
                    print(error.localizedDescription)
                }
            ).disposed(by: disposeBag)
    }
    
    private func performAfterHomeList(_ elements: [HomeElement]) {
        self.homeElements = elements
        let models = elements.map { element -> HomeListCellModel in
            return .init(
                title: element.title,
                type: element.fileType == .directory ? .folder : .file
            )
        }
        presenter.updateModels(models)
    }
    
}
