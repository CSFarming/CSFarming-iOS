//
//  ArchiveInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/3/23.
//

import Foundation
import RIBs
import RxSwift
import ArchiveInterface
import ArchiveService
import BaseService

protocol ArchiveRouting: ViewableRouting {
    func attachArchiveList(title: String, path: String)
    func detachArchiveList()
    func attachMarkdownContent(title: String, path: String)
    func detachMarkdownContent()
}

protocol ArchivePresentable: Presentable {
    var listener: ArchivePresentableListener? { get set }
    func updateModels(_ models: [ArchiveCellModel])
}

protocol ArchiveInteractorDependency: AnyObject {
    var archiveService: ArchiveServiceInterface { get }
}

final class ArchiveInteractor: PresentableInteractor<ArchivePresentable>, ArchiveInteractable, ArchivePresentableListener {
    
    weak var router: ArchiveRouting?
    weak var listener: ArchiveListener?
    
    private var elements: [ContentElement] = []
    
    private let dependency: ArchiveInteractorDependency
    private let disposeBag = DisposeBag()
    
    init(
        presenter: ArchivePresentable,
        dependency: ArchiveInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        fetchList()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didSelect(at indexPath: IndexPath) {
        guard let element = elements[safe: indexPath.row] else { return }
        if element.fileType == .directory {
            router?.attachArchiveList(title: element.title, path: element.path)
        } else if element.fileType == .markdown {
            router?.attachMarkdownContent(title: element.title, path: element.path)
        }
    }
    
    func archiveListDidTapClose() {
        router?.detachArchiveList()
    }
    
    func markdownContentDidTapClose() {
        router?.detachMarkdownContent()
    }
    
    private func fetchList() {
        dependency.archiveService
            .requestElements()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                with: self, 
                onSuccess: { this, elements in
                    this.performAfterFetchingList(elements)
                },
                onFailure: { this, error in
                    print(error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func performAfterFetchingList(_ elements: [ContentElement]) {
        self.elements = elements
        let models = elements.map { element -> ArchiveCellModel in
            return .init(
                title: element.title,
                type: element.fileType == .directory ? .folder : .file
            )
        }
        presenter.updateModels(models)
    }
    
}
