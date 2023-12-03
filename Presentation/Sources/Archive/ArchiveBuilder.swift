//
//  ArchiveBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/3/23.
//

import RIBs
import ArchiveInterface

public protocol ArchiveDependency: Dependency {}

final class ArchiveComponent: Component<ArchiveDependency> {}

public final class ArchiveBuilder: Builder<ArchiveDependency>, ArchiveBuildable {
    
    public override init(dependency: ArchiveDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: ArchiveListener) -> ViewableRouting {
        let component = ArchiveComponent(dependency: dependency)
        let viewController = ArchiveViewController()
        let interactor = ArchiveInteractor(presenter: viewController)
        interactor.listener = listener
        return ArchiveRouter(interactor: interactor, viewController: viewController)
    }
    
}
