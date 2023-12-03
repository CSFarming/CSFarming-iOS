//
//  ArchiveListRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 12/2/23.
//

import RIBs
import RIBsUtil
import MarkdownContentInterface

protocol ArchiveListInteractable: Interactable, ArchiveListListener, MarkdownContentListener {
    var router: ArchiveListRouting? { get set }
    var listener: ArchiveListListener? { get set }
}

protocol ArchiveListViewControllable: ViewControllable {}

final class ArchiveListRouter: ViewableRouter<ArchiveListInteractable, ArchiveListViewControllable>, ArchiveListRouting {
    
    private let archiveListBuilder: ArchiveListBuildable
    private var archiveListRouting: ViewableRouting?
    
    private let markdownContentBuilder: MarkdownContentBuildable
    private var markdownContentRouting: ViewableRouting?
    
    init(
        interactor: ArchiveListInteractable,
        viewController: ArchiveListViewControllable,
        archiveListBuilder: ArchiveListBuildable,
        markdownContentBuilder: MarkdownContentBuildable
    ) {
        self.archiveListBuilder = archiveListBuilder
        self.markdownContentBuilder = markdownContentBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachArchiveList(title: String, path: String) {
        guard archiveListRouting == nil else { return }
        let router = archiveListBuilder.build(withListener: interactor, title: title, path: path, isFromRoot: false)
        pushRouter(router, animated: true)
        archiveListRouting = router
    }
    
    func detachArchiveList() {
        guard let router = archiveListRouting else { return }
        popRouter(router, animated: true)
        archiveListRouting = nil
    }
    
    func attachMarkdownContent(title: String, path: String) {
        guard markdownContentRouting == nil else { return }
        let router = markdownContentBuilder.build(withListener: interactor, title: title, path: path, isFromRoot: false)
        pushRouter(router, animated: true)
        markdownContentRouting = router
    }
    
    func detachMarkdownContent() {
        guard let router = markdownContentRouting else { return }
        popRouter(router, animated: true)
        markdownContentRouting = nil
    }
    
}
