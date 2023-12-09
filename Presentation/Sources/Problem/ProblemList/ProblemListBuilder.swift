//
//  ProblemListBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 12/9/23.
//

import RIBs
import ProblemService

protocol ProblemListDependency: Dependency {
    var problemService: ProblemServiceInterface { get }
}

final class ProblemListComponent: Component<ProblemListDependency>, ProblemListInteractorDependency {
    
    let title: String
    let directory: String
    var problemService: ProblemServiceInterface { dependency.problemService }
    
    init(dependency: ProblemListDependency, title: String, directory: String) {
        self.title = title
        self.directory = directory
        super.init(dependency: dependency)
    }
    
}

protocol ProblemListBuildable: Buildable {
    func build(withListener listener: ProblemListListener, title: String, directory: String) -> ViewableRouting
}

final class ProblemListBuilder: Builder<ProblemListDependency>, ProblemListBuildable {
    
    override init(dependency: ProblemListDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: ProblemListListener,  title: String, directory: String) -> ViewableRouting {
        let component = ProblemListComponent(dependency: dependency, title: title, directory: directory)
        let viewController = ProblemListViewController()
        let interactor = ProblemListInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return ProblemListRouter(interactor: interactor, viewController: viewController)
    }
    
}
