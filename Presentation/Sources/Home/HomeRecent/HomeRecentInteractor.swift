//
//  HomeRecentInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/20/23.
//

import Foundation
import RIBs
import RxSwift
import HomeService
import BaseService

protocol HomeRecentRouting: ViewableRouting {}

protocol HomeRecentPresentable: Presentable {
    var listener: HomeRecentPresentableListener? { get set }
    func setup(items: [HomeRecentItem])
}

protocol HomeRecentListener: AnyObject {
    func homeRecentDidTapMarkdownContent(title: String, path: String)
}

protocol HomeRecentInteractorDependency: AnyObject {
    var homeService: HomeServiceInterface { get }
}

final class HomeRecentInteractor: PresentableInteractor<HomeRecentPresentable>, HomeRecentInteractable, HomeRecentPresentableListener {
    
    weak var router: HomeRecentRouting?
    weak var listener: HomeRecentListener?
    
    private var elements: [HomeElement] = []
    
    private let dependency: HomeRecentInteractorDependency
    private let disposeBag = DisposeBag()
    private var isFirstAppear = true
    private let maximumContentSize = 5
    private let timeFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.dateTimeStyle = .named
        formatter.unitsStyle = .short
        return formatter
    }()
    
    init(
        presenter: HomeRecentPresentable,
        dependency: HomeRecentInteractorDependency
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
    
    func didSelect(at index: Int) {
        guard let element = elements[safe: index] else { return }
        listener?.homeRecentDidTapMarkdownContent(title: element.title, path: element.path)
    }
    
    func viewWillAppear() {
        guard isFirstAppear == false else {
            isFirstAppear = false
            return
        }
        dependency.homeService.requestVisitHistory()
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
        let items = elements.prefix(maximumContentSize).map { element -> HomeRecentItem in
            return .post(.init(
                title: element.title,
                category: generateCategory(path: element.path),
                visitied: timeFormatter.localizedString(for: element.createdAt, relativeTo: .now)
            ))
        }
        presenter.setup(items: items)
    }
    
    private func generateCategory(path: String) -> String {
        guard let category = path.split(whereSeparator: { $0 == "/" }).dropLast().first else {
            return "카테고리 없음"
        }
        return String(category)
    }
    
}
