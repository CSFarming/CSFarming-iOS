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

protocol HomeFarmingListener: AnyObject {
    func homeFarmingDidTapChart()
}

protocol HomeFarmingInteractorDependency: AnyObject {
    var homeService: HomeServiceInterface { get }
}

final class HomeFarmingInteractor: PresentableInteractor<HomeFarmingPresentable>, HomeFarmingInteractable, HomeFarmingPresentableListener {
    
    weak var router: HomeFarmingRouting?
    weak var listener: HomeFarmingListener?
    
    private var elements: [FarmingElement] = []
    private var isFirstAppear = true
    
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
    
    func didTapChart() {
        listener?.homeFarmingDidTapChart()
    }
    
    func viewWillAppear() {
        guard isFirstAppear == false else {
            isFirstAppear = false
            return
        }
        fetchChartList()
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
        if self.elements == elements {
            return
        }
        self.elements = elements
        let model = generateChartModel(elements)
        presenter.setup(model: model)
    }
    
    private func generateChartModel(_ elements: [FarmingElement]) -> HomeFarmingChartViewModel {
        let maxScore = elements.map(\.totalScore).max() ?? 1
        let barModels: [HomeFarmingChartBarViewModel] = generateDefaultDayModel()
            .map { model in
                let score = elements.first(where: { Calendar.current.component(.day, from: $0.date) == model.day } )?.totalScore ?? 0
                return .init(score: score, maxScore: maxScore, dayModel: model)
            }
        
        return .init(barModels: barModels)
    }
    
    private func generateDefaultDayModel() -> [HomeFarmingChartBarDayViewModel] {
        return (-6...0)
            .compactMap { offset in
                Calendar.current.date(byAdding: .day, value: offset, to: .now)
            }
            .map { date in
                return .init(
                    day: Calendar.current.component(.day, from: date),
                    type: generateBarType(date: date)
                )
            }
    }
    
    private func generateBarType(date: Date) -> HomeFarmingChartBarDayType {
        let weekday = Calendar.current.component(.weekday, from: date)
        let today = Calendar.current.component(.day, from: .now)
        let day = Calendar.current.component(.day, from: date)
        
        if today == day { return .today }
        
        switch weekday {
        case 1: return .sunday
        case 7: return .saturday
        default: return .normal
        }
    }
    
}
