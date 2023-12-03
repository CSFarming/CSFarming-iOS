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
    
    private var elements: [HomeElement] = []
    
    private let dependency: HomeInteractorDependency
    private let disposeBag = DisposeBag()
    private var isFirstAppear = true
    private let timeFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.dateTimeStyle = .named
        formatter.unitsStyle = .short
        return formatter
    }()
    
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
        dependency.homeService.requestVisitHistory()
        observeCurrentHistory()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didSelect(at indexPath: IndexPath) {
        guard let element = elements[safe: indexPath.row] else { return }
        router?.attachMarkdownContent(title: element.title, path: element.path)
    }
    
    func viewWillAppear() {
        guard isFirstAppear == false else {
            isFirstAppear = false
            return
        }
        dependency.homeService.requestVisitHistory()
    }
    
    func markdownContentDidTapClose() {
        router?.detachMarkdownContent()
    }
    
    private func observeCurrentHistory() {
        dependency.homeService
            .currentHistory
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                with: self,
                onNext: { this, elements in
                    this.performAfterFetchingRecentVisit(elements)
                },
                onError: { this, error in
                    print(error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func performAfterFetchingRecentVisit(_ elements: [HomeElement]) {
        self.elements = elements
        let models = elements.map { element -> HomeItem in
            return .recentPost(.init(
                title: element.title,
                category: generateCategory(path: element.path),
                visitied: timeFormatter.localizedString(for: element.createdAt, relativeTo: .now)
            ))
        }
        presenter.updateSections([
            .recentPost(models)
        ])
    }
    
    private func generateCategory(path: String) -> String {
        guard let category = path.split(whereSeparator: { $0 == "/" }).dropLast().first else {
            return "카테고리 없음"
        }
        return String(category)
    }
    
}
