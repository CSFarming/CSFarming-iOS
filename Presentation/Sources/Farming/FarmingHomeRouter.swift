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

protocol FarmingHomeInteractable: Interactable, FarmingQuestionListener, FarmingChartListener {
    var router: FarmingHomeRouting? { get set }
    var listener: FarmingHomeListener? { get set }
}

protocol FarmingHomeViewControllable: ViewControllable {}

final class FarmingHomeRouter: ViewableRouter<FarmingHomeInteractable, FarmingHomeViewControllable>, FarmingHomeRouting {
    
    private let farmingQuestionBuiler: FarmingQuestionBuildable
    private var farmingQuestionRouting: ViewableRouting?
    
    private let farmingChartBuilder: FarmingChartBuildable
    private var farmingChartRouting: ViewableRouting?
    
    init(
        interactor: FarmingHomeInteractable,
        viewController: FarmingHomeViewControllable,
        farmingQuestionBuiler: FarmingQuestionBuildable,
        farmingChartBuilder: FarmingChartBuildable
    ) {
        self.farmingQuestionBuiler = farmingQuestionBuiler
        self.farmingChartBuilder = farmingChartBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachQuestion(element: FarmingProblemElement) {
        guard farmingQuestionRouting == nil else { return }
        let router = farmingQuestionBuiler.build(withListener: interactor, element: element)
        pushRouter(router, animated: true)
        farmingQuestionRouting = router
    }
    
    func detachQuestion() {
        guard let router = farmingQuestionRouting else { return }
        popRouter(router, animated: true)
        farmingQuestionRouting = nil
    }
    
    func attachChart() {
        guard farmingChartRouting == nil else { return }
        let router = farmingChartBuilder.build(withListener: interactor)
        pushRouter(router, animated: true)
        farmingChartRouting = router
    }
    
    func detachChart() {
        guard let router = farmingChartRouting else { return }
        popRouter(router, animated: true)
        farmingChartRouting = nil
    }
    
}
