//
//  FarmingHomeRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 12/21/23.
//

import RIBs
import RIBsUtil
import FarmingInterface
import FarmingService

protocol FarmingHomeInteractable: Interactable, FarmingQuestionListener {
    var router: FarmingHomeRouting? { get set }
    var listener: FarmingHomeListener? { get set }
}

protocol FarmingHomeViewControllable: ViewControllable {}

final class FarmingHomeRouter: ViewableRouter<FarmingHomeInteractable, FarmingHomeViewControllable>, FarmingHomeRouting {
    
    private let farmingQuestionBuiler: FarmingQuestionBuildable
    private var farmingQuestionRouting: ViewableRouting?
    
    init(
        interactor: FarmingHomeInteractable,
        viewController: FarmingHomeViewControllable,
        farmingQuestionBuiler: FarmingQuestionBuildable
    ) {
        self.farmingQuestionBuiler = farmingQuestionBuiler
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachQuestion(element: FarmingProblemElement) {
        guard farmingQuestionRouting == nil else { return }
        let router = farmingQuestionBuiler.build(withListener: interactor, element: element)
        pushRouter(router, animated: true)
    }
    
}
