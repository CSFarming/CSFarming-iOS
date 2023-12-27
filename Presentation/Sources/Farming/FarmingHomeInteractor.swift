//
//  FarmingHomeInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/21/23.
//

import Foundation
import RIBs
import RxSwift
import CoreUtil
import FarmingInterface
import FarmingService

protocol FarmingHomeRouting: ViewableRouting {
    func attachQuestion(element: FarmingProblemElement)
    func detachQuestion()
    func attachChart()
    func detachChart()
}

protocol FarmingHomePresentable: Presentable {
    var listener: FarmingHomePresentableListener? { get set }
    func updateTitle(_ title: String)
    func updateSections(_ sections: [FarmingHomeSection])
}

protocol FarmingHomeInteractorDependency: AnyObject {
    var farmingService: FarmingServiceInterface { get }
}

final class FarmingHomeInteractor: PresentableInteractor<FarmingHomePresentable>, FarmingHomeInteractable, FarmingHomePresentableListener {
    
    weak var router: FarmingHomeRouting?
    weak var listener: FarmingHomeListener?
    
    private var element: FarmingElement?
    private var sections: [FarmingHomeSection] = []
    
    private let dependency: FarmingHomeInteractorDependency
    private let disposeBag = DisposeBag()
    private let timeFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.dateTimeStyle = .named
        formatter.unitsStyle = .short
        return formatter
    }()
    
    init(
        presenter: FarmingHomePresentable,
        dependency: FarmingHomeInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.updateTitle("나의 파밍")
        requestFarmingElement()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapClose() {
        listener?.farmingHomeDidTapClose()
    }
    
    func didTap(at indexPath: IndexPath) {
        guard let section = sections[safe: indexPath.section] else { return }
        
        switch section {
        case .statistics:
            router?.attachChart()
            
        case .farming:
            guard let problemElement = element?.problems[safe: indexPath.row - 1] else { return }
            router?.attachQuestion(element: problemElement)
        }
    }
    
    func farmingQuestionDidTapClose() {
        router?.detachQuestion()
    }
    
    func farmingChartDidTapClose() {
        router?.detachChart()
    }
    
    private func requestFarmingElement() {
        dependency.farmingService
            .read()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                with: self,
                onSuccess: { this, element in
                    guard let element else {
                        this.presenter.updateSections([.farming([.empty])])
                        return
                    }
                    this.performAfterFecthingFarmingElement(element)
                },
                onFailure: { this, error in
                    this.presenter.updateSections([.farming([.empty])])
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func performAfterFecthingFarmingElement(_ element: FarmingElement) {
        self.element = element
        let studyItem: FarmingHomeItem = .study(.init(score: element.activityScore, title: "학습"))
        let problemItems: [FarmingHomeItem] = element.problems.map { .problem(.init(
            score: $0.score,
            title: $0.title,
            date: timeFormatter.localizedString(for: $0.createdAt, relativeTo: .now)
        ))}
        
        let newSections: [FarmingHomeSection] = [
            .statistics([.chart(.init(title: "파밍 통계", description: "7일 동안의 차트를 볼 수 있어요"))]),
            .farming([studyItem] + problemItems)
        ]
        sections = newSections
        presenter.updateSections(newSections)
    }
    
}
