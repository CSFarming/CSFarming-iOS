//
//  HomeFarmingInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/20/23.
//

import RIBs
import RxSwift

protocol HomeFarmingRouting: ViewableRouting {}

protocol HomeFarmingPresentable: Presentable {
    var listener: HomeFarmingPresentableListener? { get set }
    func setup(model: HomeFarmingChartViewModel)
}

protocol HomeFarmingListener: AnyObject {}

final class HomeFarmingInteractor: PresentableInteractor<HomeFarmingPresentable>, HomeFarmingInteractable, HomeFarmingPresentableListener {
    
    weak var router: HomeFarmingRouting?
    weak var listener: HomeFarmingListener?
    
    override init(presenter: HomeFarmingPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        fetchChartList()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    private func fetchChartList() {
        presenter.setup(model: .init(barModels: [
            .init(score: 2, maxScore: 5, dayModel: .init(day: 14, type: .normal)),
            .init(score: 5, maxScore: 5, dayModel: .init(day: 15, type: .normal)),
            .init(score: 1, maxScore: 5, dayModel: .init(day: 16, type: .saturday)),
            .init(score: 3, maxScore: 5, dayModel: .init(day: 17, type: .sunday)),
            .init(score: 2, maxScore: 5, dayModel: .init(day: 18, type: .normal)),
            .init(score: 4, maxScore: 5, dayModel: .init(day: 19, type: .normal)),
            .init(score: 1, maxScore: 5, dayModel: .init(day: 20, type: .today)),
        ]))
    }
    
}
