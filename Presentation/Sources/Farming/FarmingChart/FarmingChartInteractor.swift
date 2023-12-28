//
//  FarmingChartInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/26/23.
//

import Foundation
import RIBs
import RxSwift
import CoreUtil
import FarmingService

protocol FarmingChartRouting: ViewableRouting {}

protocol FarmingChartPresentable: Presentable {
    var listener: FarmingChartPresentableListener? { get set }
    func updateTitle(_ title: String)
    func updateContent(_ content: FarmingChartContent)
    func updateChartDescription(_ description: FarmingChartDescription?)
}

protocol FarmingChartListener: AnyObject {
    func farmingChartDidTapClose()
}

protocol FarmingChartInteractorDependency: AnyObject {
    var farmingService: FarmingServiceInterface { get }
}

final class FarmingChartInteractor: PresentableInteractor<FarmingChartPresentable>, FarmingChartInteractable, FarmingChartPresentableListener {
    
    weak var router: FarmingChartRouting?
    weak var listener: FarmingChartListener?
    
    private let dependency: FarmingChartInteractorDependency
    private let daysAgoValue = 7
    private let disposeBag = DisposeBag()
    private var chartGroups: [FarmingChartGroup] = []
    
    init(presenter: FarmingChartPresentable, dependency: FarmingChartInteractorDependency) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.updateTitle("파밍 통계")
        requestElements()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapClose() {
        listener?.farmingChartDidTapClose()
    }
    
    func didChangeSelectedDate(_ date: Date?) {
        guard let date else {
            presenter.updateChartDescription(nil)
            return
        }
        
        let okCount = chartGroups
            .filter({ $0.type == .ok })
            .flatMap(\.elements)
            .filter { $0.date.isSameDay(date: date) }
            .map(\.value)
            .reduce(0, +)
        
        let passCount = chartGroups
            .filter({ $0.type == .pass })
            .flatMap(\.elements)
            .filter { $0.date.isSameDay(date: date) }
            .map(\.value)
            .reduce(0, +)
        
        presenter.updateChartDescription(.init(
            title: "\(date.year)년 \(date.month)월 \(date.day)일",
            okCount: okCount,
            passCount: passCount
        ))
    }
    
    private func requestElements() {
        dependency.farmingService.read(daysAgo: daysAgoValue)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                with: self,
                onSuccess: { this, elements in
                    this.performAfterFetchingElements(elements)
                },
                onFailure: { this, error in
                    print(error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func performAfterFetchingElements(_ elements: [FarmingElement]) {
        let groups = makeChartGroups(elements)
        let description = makeChartDescription(elements)
        chartGroups = groups
        presenter.updateContent(.init(description: description, groups: groups))
    }
    
    private func makeChartGroups(_ elements: [FarmingElement]) -> [FarmingChartGroup] {
        var okElements: [FarmingChartElement] = []
        var passElements: [FarmingChartElement] = []
        
        elements.sorted(by: { $0.date > $1.date })
            .forEach { element in
                let ok = element.problems.map { $0.items.filter { $0.isCorrect }.count }.reduce(0, +)
                let pass = element.problems.map { $0.items.filter { !$0.isCorrect }.count }.reduce(0, +)
                okElements.append(.init(date: element.date, value: ok))
                passElements.append(.init(date: element.date, value: pass))
            }
        return [
            .init(type: .ok, elements: okElements),
            .init(type: .pass, elements: passElements)
        ]
    }
    
    private func makeChartDescription(_ elements: [FarmingElement]) -> String {
        let okCount = elements.map { $0.problems.flatMap(\.items).filter { $0.isCorrect }.count }.reduce(0, +)
        let passCount = elements.map { $0.problems.flatMap(\.items).filter { !$0.isCorrect }.count }.reduce(0, +)
        
        return "\(daysAgoValue)일 동안 총 \(okCount)개의 문제를 맞히고 \(passCount)개의 문제를 틀렸어요"
    }
    
}
