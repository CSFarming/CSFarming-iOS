//
//  FarmingQuestionInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/23/23.
//

import Foundation
import RIBs
import RxSwift
import CoreUtil
import FarmingService

protocol FarmingQuestionRouting: ViewableRouting {}

protocol FarmingQuestionPresentable: Presentable {
    var listener: FarmingQuestionPresentableListener? { get set }
    func updateTitle(_ title: String)
    func updateSections(_ sections: [FarmingQuestionSection])
    func updateModel(at indexPath: IndexPath, model: FarmingQuestionCellModel)
}

protocol FarmingQuestionListener: AnyObject {
    func farmingQuestionDidTapClose()
}

protocol FarmingQuestionInteractorDependency: AnyObject {
    var element: FarmingProblemElement { get }
}

final class FarmingQuestionInteractor: PresentableInteractor<FarmingQuestionPresentable>, FarmingQuestionInteractable, FarmingQuestionPresentableListener {
    
    weak var router: FarmingQuestionRouting?
    weak var listener: FarmingQuestionListener?
    
    private let depenedency: FarmingQuestionInteractorDependency
    private var sections: [FarmingQuestionSection] = []
    
    init(
        presenter: FarmingQuestionPresentable,
        depenedency: FarmingQuestionInteractorDependency
    ) {
        self.depenedency = depenedency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        updatePresentable()
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapClose() {
        listener?.farmingQuestionDidTapClose()
    }
    
    func didTap(at indexPath: IndexPath) {
        guard let model = sections[safe: indexPath.section]?.items[safe: indexPath.row] else {
            return
        }
        let newModel = FarmingQuestionCellModel(question: model.question, answer: model.answer, isOpened: !model.isOpened)
        sections = sections.updating(at: indexPath, model: newModel)
        presenter.updateModel(at: indexPath, model: newModel)
    }
    
    private func updatePresentable() {
        presenter.updateTitle(depenedency.element.title)
        
        var okModels: [FarmingQuestionCellModel] = []
        var passModels: [FarmingQuestionCellModel] = []
        
        depenedency.element.items.forEach { item in
            let model = FarmingQuestionCellModel(question: item.question, answer: item.answer, isOpened: false)
            if item.isCorrect {
                okModels.append(model)
            } else {
                passModels.append(model)
            }
        }
        
        var newSections: [FarmingQuestionSection] = []
        
        if okModels.isEmpty == false {
            newSections.append(.ok(okModels))
        }
        
        if passModels.isEmpty == false {
            newSections.append(.pass(passModels))
        }
        
        self.sections = newSections
        presenter.updateSections(newSections)
    }
    
}
