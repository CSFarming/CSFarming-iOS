//
//  MarkdownContentBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/2/23.
//

import RIBs
import MarkdownService
import MarkdownContentInterface

public protocol MarkdownContentDependency: Dependency {
    var markdownService: MarkdownServiceInterface { get }
}

final class MarkdownContentComponent: Component<MarkdownContentDependency>, MarkdownContentInteractorDependency {
    var markdownService: MarkdownServiceInterface { dependency.markdownService }
    let title: String
    let path: String
    let isFromRoot: Bool
    
    init(dependency: MarkdownContentDependency, title: String, path: String, isFromRoot: Bool) {
        self.title = title
        self.path = path
        self.isFromRoot = isFromRoot
        super.init(dependency: dependency)
    }
}

public final class MarkdownContentBuilder: Builder<MarkdownContentDependency>, MarkdownContentBuildable {
    
    public override init(dependency: MarkdownContentDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: MarkdownContentListener, title: String, path: String, isFromRoot: Bool) -> ViewableRouting {
        let component = MarkdownContentComponent(
            dependency: dependency, 
            title: title,
            path: path,
            isFromRoot: isFromRoot
        )
        let viewController = MarkdownContentViewController(rootView: MarkdownContentView())
        let interactor = MarkdownContentInteractor(
            presenter: viewController,
            dependency: component
        )
        interactor.listener = listener
        return MarkdownContentRouter(interactor: interactor, viewController: viewController)
    }
    
}
