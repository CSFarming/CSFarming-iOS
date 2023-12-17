//
//  ProblemBuilder.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import RIBs
import ProblemInterface
import ProblemService
import QuestionInterface

public protocol ProblemDependency: Dependency {
    var problemService: ProblemServiceInterface { get }
    var questionBuilder: QuestionBuildable { get }
    var questionCreateBuilder: QuestionCreateBuildable { get }
}

final class ProblemComponent: Component<ProblemDependency>, ProblemInteractorDependency, ProblemListDependency, ProblemCreateDependency {
    var problemService: ProblemServiceInterface { dependency.problemService }
    var questionBuilder: QuestionBuildable { dependency.questionBuilder }
    var questionCreateBuilder: QuestionCreateBuildable { dependency.questionCreateBuilder }
}

public final class ProblemBuilder: Builder<ProblemDependency>, ProblemBuildable {
    
    public override init(dependency: ProblemDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: ProblemListener) -> ViewableRouting {
        let component = ProblemComponent(dependency: dependency)
        let viewController = ProblemViewController()
        let interactor = ProblemInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return ProblemRouter(
            interactor: interactor,
            viewController: viewController,
            questionBuilder: component.questionBuilder,
            problemBuilder: ProblemListBuilder(dependency: component),
            problemCreateBuilder: ProblemCreateBuilder(dependency: component)
        )
    }
    
}
