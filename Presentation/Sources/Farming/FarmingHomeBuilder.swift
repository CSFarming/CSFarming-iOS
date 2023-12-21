//
//  FarmingHomeBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/21/23.
//

import RIBs
import FarmingInterface

public protocol FarmingHomeDependency: Dependency {}

final class FarmingHomeComponent: Component<FarmingHomeDependency> {}

public final class FarmingHomeBuilder: Builder<FarmingHomeDependency>, FarmingHomeBuildable {
    
    public override init(dependency: FarmingHomeDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: FarmingHomeListener) -> ViewableRouting {
        let component = FarmingHomeComponent(dependency: dependency)
        let viewController = FarmingHomeViewController()
        let interactor = FarmingHomeInteractor(presenter: viewController)
        interactor.listener = listener
        return FarmingHomeRouter(interactor: interactor, viewController: viewController)
    }
    
}
