//
//  FarmingHomeInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/21/23.
//

import Foundation
import RIBs
import RxSwift
import FarmingInterface
import FarmingService

protocol FarmingHomeRouting: ViewableRouting {}

protocol FarmingHomePresentable: Presentable {
    var listener: FarmingHomePresentableListener? { get set }
    func updateTitle(_ title: String)
    func updateModels(_ models: [FarmingHomeItem])
}

protocol FarmingHomeInteractorDependency: AnyObject {
    var farmingService: FarmingServiceInterface { get }
}

final class FarmingHomeInteractor: PresentableInteractor<FarmingHomePresentable>, FarmingHomeInteractable, FarmingHomePresentableListener {
    
    weak var router: FarmingHomeRouting?
    weak var listener: FarmingHomeListener?
    
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
        
    }
    
    private func requestFarmingElement() {
        dependency.farmingService
            .read()
            .compactMap { $0 }
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                with: self,
                onSuccess: { this, element in
                    this.performAfterFecthingFarmingElement(element)
                },
                onError: { this, error in
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func performAfterFecthingFarmingElement(_ element: FarmingElement) {
        let studyItem: FarmingHomeItem = .study(.init(score: element.activityScore, title: "학습"))
        let problemItems: [FarmingHomeItem] = element.problems.map { .problem(.init(
            score: $0.score,
            title: $0.title,
            date: timeFormatter.localizedString(for: $0.createdAt, relativeTo: .now)
        ))}
        presenter.updateModels([studyItem] + problemItems)
    }
    
}
