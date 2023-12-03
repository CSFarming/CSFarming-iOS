//
//  ArchiveRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 12/3/23.
//

import RIBs
import RIBsUtil
import ArchiveInterface
import MarkdownContentInterface

protocol ArchiveInteractable: Interactable, ArchiveListListener, MarkdownContentListener {
    var router: ArchiveRouting? { get set }
    var listener: ArchiveListener? { get set }
}

protocol ArchiveViewControllable: ViewControllable {}

final class ArchiveRouter: ViewableRouter<ArchiveInteractable, ArchiveViewControllable>, ArchiveRouting {
    
    private let archiveListBuilder: ArchiveListBuildable
    private var archiveListRouting: ViewableRouting?
    
    private let markdownContentBuilder: MarkdownContentBuildable
    private var markdownContentRouting: ViewableRouting?
    
    init(
        interactor: ArchiveInteractable,
        viewController: ArchiveViewControllable,
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
        let router = archiveListBuilder.build(withListener: interactor, title: title, path: path, isFromRoot: true)
        pushRouter(router, animated: true)
        self.archiveListRouting = router
    }
    
    func detachArchiveList() {
        guard let router = archiveListRouting else { return }
        popRouter(router, animated: true)
        self.archiveListRouting = nil
    }
    
    func attachMarkdownContent(title: String, path: String) {
        guard markdownContentRouting == nil else { return }
        let router = markdownContentBuilder.build(withListener: interactor, title: title, path: path, isFromRoot: true)
        pushRouter(router, animated: true)
        self.markdownContentRouting = router
    }
    
    func detachMarkdownContent() {
        guard let router = markdownContentRouting else { return }
        popRouter(router, animated: true)
        self.markdownContentRouting = nil
    }
    
}
