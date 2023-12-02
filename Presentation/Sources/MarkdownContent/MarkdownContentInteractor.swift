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
    }
    
    override func willResignActive() {
        super.willResignActive()
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
                    print(source)
                },
                onFailure: { this, error in
                    print(error.localizedDescription)
                }
            ).disposed(by: disposeBag)
    }
    
}
