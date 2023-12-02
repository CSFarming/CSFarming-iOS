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
}

final class HomeListInteractor: PresentableInteractor<HomeListPresentable>, HomeListInteractable, HomeListPresentableListener {
    
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
    
    private func fetchHomeList() {
        dependency.homeService
            .requestElements(path: dependency.path)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                with: self,
                onSuccess: { this, elements in
                    this.performAfterHomeList(elements)
                    print(elements)
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
