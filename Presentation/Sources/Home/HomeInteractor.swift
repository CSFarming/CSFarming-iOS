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
    func attachHomeList(title: String, path: String)
    func detachHomeList()
    func attachMarkdownContent(title: String, path: String)
    func detachMarkdownContent()
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
    
    private var elements: [[ContentElement]] = []
    
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
        fetchContents()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didSelect(at indexPath: IndexPath) {
        guard let element = elements[safe: indexPath.section]?[safe: indexPath.row] else { return }
        if element.fileType == .directory {
            router?.attachHomeList(title: element.title, path: element.path)
        } else {
            router?.attachMarkdownContent(title: element.title, path: element.path)
        }
    }
    
    func homeListDidTapClose() {
        router?.detachHomeList()
    }
    
    func markdownContentDidTapClose() {
        router?.detachMarkdownContent()
    }
    
    private func fetchContents() {
        Observable.combineLatest(
            dependency.homeService.requestElements().asObservable(),
            dependency.homeService.requestVisitHistory().asObservable()
        ).observe(on: MainScheduler.asyncInstance)
            .subscribe(
                with: self, 
                onNext: { this, content in
                    this.performAfterFetchingContents(homeContents: content.0, historyContents: content.1)
                },
                onError: { this, error in
                    print(error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
        
    }
    
    private func performAfterFetchingContents(homeContents: [ContentElement], historyContents: [ContentElement]) {
        self.elements = [homeContents, historyContents]
        
        let homeModels = homeContents.map { element -> HomeItem in
            return .recentPost(.init(
                title: element.title,
                type: element.fileType == .directory ? .folder : .file
            ))
        }
        
        let historyModels = historyContents.map { element -> HomeItem in
            return .recentPost(.init(
                title: element.title,
                type: element.fileType == .directory ? .folder : .file
            ))
        }
        presenter.updateSections([
            .recentPost(homeModels),
            .recentProblem(historyModels)
        ])
    }
    
}
