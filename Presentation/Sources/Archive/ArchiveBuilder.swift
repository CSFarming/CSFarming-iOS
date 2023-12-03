//
//  ArchiveBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/3/23.
//

import RIBs
import ArchiveInterface
import ArchiveService
import MarkdownContentInterface

public protocol ArchiveDependency: Dependency {
    var archiveService: ArchiveServiceInterface { get }
    var markdownContentBuilder: MarkdownContentBuildable { get }
}

final class ArchiveComponent: Component<ArchiveDependency>, ArchiveInteractorDependency, ArchiveListDependency {
    var archiveService: ArchiveServiceInterface { dependency.archiveService }
    var markdownContentBuilder: MarkdownContentBuildable { dependency.markdownContentBuilder }
}

public final class ArchiveBuilder: Builder<ArchiveDependency>, ArchiveBuildable {
    
    public override init(dependency: ArchiveDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: ArchiveListener) -> ViewableRouting {
        let component = ArchiveComponent(dependency: dependency)
        let viewController = ArchiveViewController()
        let interactor = ArchiveInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return ArchiveRouter(
            interactor: interactor, 
            viewController: viewController,
            archiveListBuilder: ArchiveListBuilder(dependency: component),
            markdownContentBuilder: component.markdownContentBuilder
        )
    }
    
}
