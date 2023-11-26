//
//  HomeInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import Foundation
import RIBs
import RxSwift
import HomeInterface

protocol HomeRouting: ViewableRouting {}

protocol HomePresentable: Presentable {
    var listener: HomePresentableListener? { get set }
    func updateSections(_ sections: [HomeSection])
}

final class HomeInteractor: PresentableInteractor<HomePresentable>, HomeInteractable, HomePresentableListener {
    
    weak var router: HomeRouting?
    weak var listener: HomeListener?
    
    override init(presenter: HomePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.updateSections([
            .recentPost([
                .recentPost(.init(title: "시스템 콜", iconImageURL: "")),
                .recentPost(.init(title: "시스템 콜2", iconImageURL: "")),
                .recentPost(.init(title: "시스템 콜3", iconImageURL: "")),
            ]),
            .recentProblem([
                .recentProblem(.init(title: "문제입니다", subtitle: "11문제", iconImageURL: "", progressContent: "60%")),
                .recentProblem(.init(title: "문제입니다", subtitle: "11문제", iconImageURL: "", progressContent: "60%")),
                .recentProblem(.init(title: "문제입니다", subtitle: "11문제", iconImageURL: "", progressContent: "60%")),
                .recentProblem(.init(title: "문제입니다", subtitle: "11문제", iconImageURL: "", progressContent: "60%")),
                .recentProblem(.init(title: "문제입니다", subtitle: "11문제", iconImageURL: "", progressContent: "60%")),
            ])
        ])
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didSelect(at indexPath: IndexPath) {
        print("# Did Select At: \(indexPath)")
        
    }
    
}
