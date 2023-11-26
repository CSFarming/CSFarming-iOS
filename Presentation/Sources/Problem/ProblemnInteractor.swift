//
//  ProblemInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import RIBs
import RxSwift
import ProblemInterface

protocol ProblemRouting: ViewableRouting {}

protocol ProblemPresentable: Presentable {
    var listener: ProblemPresentableListener? { get set }
    func updateModels(_ models: [ProblemContentViewModel])
}

final class ProblemInteractor: PresentableInteractor<ProblemPresentable>, ProblemInteractable, ProblemPresentableListener {
    
    weak var router: ProblemRouting?
    weak var listener: ProblemListener?
    
    override init(presenter: ProblemPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.updateModels([
            .init(id: 1, title: "네트워크", subtitle: "Network"),
            .init(id: 2, title: "알고리즘", subtitle: "Algorithm"),
            .init(id: 3, title: "운영체제", subtitle: "Operating System (OS)"),
        ])
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTap(id: Int) {
        print("# TAP: \(id)")
    }
    
}
