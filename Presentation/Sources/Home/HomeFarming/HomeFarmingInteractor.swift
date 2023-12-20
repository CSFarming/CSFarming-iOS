//
//  HomeFarmingInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/20/23.
//

import Foundation
import RIBs
import RxSwift
import HomeService
import FarmingService

protocol HomeFarmingRouting: ViewableRouting {}

protocol HomeFarmingPresentable: Presentable {
    var listener: HomeFarmingPresentableListener? { get set }
    func setup(model: HomeFarmingChartViewModel)
}

protocol HomeFarmingListener: AnyObject {}

protocol HomeFarmingInteractorDependency: AnyObject {
    var homeService: HomeServiceInterface { get }
    var calendar: Calendar { get }
}

final class HomeFarmingInteractor: PresentableInteractor<HomeFarmingPresentable>, HomeFarmingInteractable, HomeFarmingPresentableListener {
    
    weak var router: HomeFarmingRouting?
    weak var listener: HomeFarmingListener?
    
    private let dependency: HomeFarmingInteractorDependency
    private let disposeBag = DisposeBag()
    
    init(
        presenter: HomeFarmingPresentable,
        dependency: HomeFarmingInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        fetchChartList()
        observeFarmingList()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    private func fetchChartList() {
        dependency.homeService.requestFarmingList()
    }
    
    private func observeFarmingList() {
        dependency.homeService
            .farmingList
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                with: self,
                onNext: { this, elements in
                    this.performAfterFetchingFarmingList(elements)
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func performAfterFetchingFarmingList(_ elements: [FarmingElement]) {
        let model = generateChartModel(elements)
        presenter.setup(model: model)
    }
    
    private func generateChartModel(_ elements: [FarmingElement]) -> HomeFarmingChartViewModel {
        let maxScore = elements.map(\.activityScore).max() ?? 1
        let barModels: [HomeFarmingChartBarViewModel] = generateDefaultDayModel()
            .map { model in
                let score = elements.first(where: { dependency.calendar.component(.day, from: $0.date) == model.day } )?.activityScore ?? 0
                return .init(score: score, maxScore: maxScore, dayModel: model)
            }
        
        return .init(barModels: barModels)
    }
    
    private func generateDefaultDayModel() -> [HomeFarmingChartBarDayViewModel] {
        return (-6...0)
            .compactMap { offset in
                dependency.calendar.date(byAdding: .day, value: offset, to: .now)
            }
            .map { date in
                return .init(
                    day: dependency.calendar.component(.day, from: date),
                    type: generateBarType(date: date)
                )
            }
    }
    
    private func generateBarType(date: Date) -> HomeFarmingChartBarDayType {
        let weekday = dependency.calendar.component(.weekday, from: date)
        let today = dependency.calendar.component(.day, from: .now)
        let day = dependency.calendar.component(.day, from: date)
        
        if today == day { return .today }
        
        switch weekday {
        case 1: return .sunday
        case 7: return .saturday
        default: return .normal
        }
    }
    
}
