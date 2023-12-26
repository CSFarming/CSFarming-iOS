//
//  FarmingChartInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/26/23.
//

import RIBs
import RxSwift
import CoreUtil
import FarmingService

protocol FarmingChartRouting: ViewableRouting {}

protocol FarmingChartPresentable: Presentable {
    var listener: FarmingChartPresentableListener? { get set }
}

protocol FarmingChartListener: AnyObject {}

protocol FarmingChartInteractorDependency: AnyObject {
    var farmingService: FarmingServiceInterface { get }
}

final class FarmingChartInteractor: PresentableInteractor<FarmingChartPresentable>, FarmingChartInteractable, FarmingChartPresentableListener {
    
    weak var router: FarmingChartRouting?
    weak var listener: FarmingChartListener?
    
    private let dependency: FarmingChartInteractorDependency
    
    init(presenter: FarmingChartPresentable, dependency: FarmingChartInteractorDependency) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
}
