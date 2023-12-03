//
//  ArchiveListInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/2/23.
//

import Foundation
import RIBs
import RxSwift
import BaseService
import ArchiveService

protocol ArchiveListRouting: ViewableRouting {
    func attachArchiveList(title: String, path: String)
    func detachArchiveList()
    func attachMarkdownContent(title: String, path: String)
    func detachMarkdownContent()
}

protocol ArchiveListPresentable: Presentable {
    var listener: ArchiveListPresentableListener? { get set }
    func updateTitle(_ title: String)
    func updateModels(_ models: [ArchiveListCellModel])
}

protocol ArchiveListListener: AnyObject {
    func archiveListDidTapClose()
}

protocol ArchiveListInteractorDependency: AnyObject {
    var archiveService: ArchiveServiceInterface { get }
    var title: String { get }
    var path: String { get }
    var isFromRoot: Bool { get }
}

final class ArchiveListInteractor: PresentableInteractor<ArchiveListPresentable>, ArchiveListInteractable, ArchiveListPresentableListener, ArchiveListListener {
    
    weak var router: ArchiveListRouting?
    weak var listener: ArchiveListListener?
    
    private var elements: [ContentElement] = []
    
    private let dependency: ArchiveListInteractorDependency
    private let disposeBag = DisposeBag()
    
    init(
        presenter: ArchiveListPresentable,
        dependency: ArchiveListInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        fetchArchiveList()
        presenter.updateTitle(dependency.title)
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapClose() {
        listener?.archiveListDidTapClose()
    }
    
    func didTap(at indexPath: IndexPath) {
        guard let element = elements[safe: indexPath.row] else { return }
        if element.fileType == .directory {
            router?.attachArchiveList(title: element.title, path: element.path)
        } else {
            router?.attachMarkdownContent(title: element.title, path: element.path)
        }
    }
    
    func archiveListDidTapClose() {
        router?.detachArchiveList()
    }
    
    func markdownContentDidTapClose() {
        router?.detachMarkdownContent()
    }
    
    private func fetchArchiveList() {
        let request: Single<[ContentElement]> = {
            if dependency.isFromRoot {
                return dependency.archiveService.requestElements(path: dependency.path)
            } else {
                return dependency.archiveService.requestElementsWithPrefix(path: dependency.path)
            }
        }()
        
        request
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                with: self,
                onSuccess: { this, elements in
                    this.performAfterFetchingArchiveList(elements)
                },
                onFailure: { this, error in
                    print(error.localizedDescription)
                }
            ).disposed(by: disposeBag)
    }
    
    private func performAfterFetchingArchiveList(_ elements: [ContentElement]) {
        self.elements = elements
        let models = elements.map { element -> ArchiveListCellModel in
            return .init(
                title: element.title,
                type: element.fileType == .directory ? .folder : .file
            )
        }
        presenter.updateModels(models)
    }
    
}
