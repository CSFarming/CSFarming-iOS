//
//  FarmingChartRouter.swift
//  CSFarming
//
//  Created by 홍성준 on 12/26/23.
//

import RIBs

protocol FarmingChartInteractable: Interactable {
    var router: FarmingChartRouting? { get set }
    var listener: FarmingChartListener? { get set }
}

protocol FarmingChartViewControllable: ViewControllable {}

final class FarmingChartRouter: ViewableRouter<FarmingChartInteractable, FarmingChartViewControllable>, FarmingChartRouting {
    
    override init(interactor: FarmingChartInteractable, viewController: FarmingChartViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
