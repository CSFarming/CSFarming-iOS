//
//  ArchiveListBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/2/23.
//

import RIBs
import ArchiveService
import MarkdownContentInterface

protocol ArchiveListDependency: Dependency {
    var archiveService: ArchiveServiceInterface { get }
    var markdownContentBuilder: MarkdownContentBuildable { get }
}

final class ArchiveListComponent: Component<ArchiveListDependency>, ArchiveListInteractorDependency {
    
    var archiveService: ArchiveServiceInterface { dependency.archiveService }
    var markdownContentBuilder: MarkdownContentBuildable { dependency.markdownContentBuilder }
    let title: String
    let path: String
    let isFromRoot: Bool
    
    init(dependency: ArchiveListDependency, title: String, path: String, isFromRoot: Bool) {
        self.title = title
        self.path = path
        self.isFromRoot = isFromRoot
        super.init(dependency: dependency)
    }
    
}

protocol ArchiveListBuildable: Buildable {
    func build(withListener listener: ArchiveListListener, title: String, path: String, isFromRoot: Bool) -> ViewableRouting
}

final class ArchiveListBuilder: Builder<ArchiveListDependency>, ArchiveListBuildable {
    
    override init(dependency: ArchiveListDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: ArchiveListListener, title: String, path: String, isFromRoot: Bool) -> ViewableRouting {
        let component = ArchiveListComponent(
            dependency: dependency,
            title: title,
            path: path,
            isFromRoot: isFromRoot
        )
        let viewController = ArchiveListViewController()
        let interactor = ArchiveListInteractor(
            presenter: viewController,
            dependency: component
        )
        interactor.listener = listener
        return ArchiveListRouter(
            interactor: interactor,
            viewController: viewController,
            archiveListBuilder: self,
            markdownContentBuilder: component.markdownContentBuilder
        )
    }
    
}
