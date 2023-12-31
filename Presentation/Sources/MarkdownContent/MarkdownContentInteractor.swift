//
//  MarkdownContentInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/2/23.
//

import RIBs
import RxSwift
import MarkdownService
import MarkdownContentInterface

protocol MarkdownContentRouting: ViewableRouting {}

protocol MarkdownContentPresentable: Presentable {
    var listener: MarkdownContentPresentableListener? { get set }
    func updateMarkdown(_ source: String)
    func updateTitle(_ title: String)
}

protocol MarkdownContentInteractorDependency: AnyObject {
    var markdownService: MarkdownServiceInterface { get }
    var title: String { get }
    var path: String { get }
    var isFromRoot: Bool { get }
}

final class MarkdownContentInteractor: PresentableInteractor<MarkdownContentPresentable>, MarkdownContentInteractable, MarkdownContentPresentableListener {
    
    weak var router: MarkdownContentRouting?
    weak var listener: MarkdownContentListener?
    
    private let dependency: MarkdownContentInteractorDependency
    private let disposeBag = DisposeBag()
    
    init(
        presenter: MarkdownContentPresentable, 
        dependency: MarkdownContentInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        fetchMarkdown()
        requestVisited()
        presenter.updateTitle(dependency.title)
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapClose() {
        listener?.markdownContentDidTapClose()
    }
    
    private func fetchMarkdown() {
        let request: Single<String> = {
            if dependency.isFromRoot {
                return dependency.markdownService.requestMarkdownFromRoot(path: dependency.path)
            } else {
                return dependency.markdownService.requestMarkdown(path: dependency.path)
            }
        }()
        
        request
            .subscribe(
                with: self,
                onSuccess: { this, source in
                    this.presenter.updateMarkdown(source)
                },
                onFailure: { this, error in
                    print(error.localizedDescription)
                }
            ).disposed(by: disposeBag)
    }
    
    private func requestVisited() {
        Observable.zip(
            dependency.markdownService.requestVisit(element: .init(title: dependency.title, path: dependency.path)).asObservable(),
            dependency.markdownService.requestVisitFarming().asObservable()
        )
        .subscribe(
            with: self,
            onNext: { this, _ in
                print("# 성공적으로 방문 기록 작성")
            },
            onError: { this, error in
                print("# 방문 기록 작성 실패: \(error.localizedDescription)")
            }
        )
        .disposed(by: disposeBag)
    }
    
}
