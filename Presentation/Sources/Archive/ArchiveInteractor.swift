//
//  ArchiveInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/3/23.
//

import RIBs
import RxSwift
import ArchiveInterface

protocol ArchiveRouting: ViewableRouting {}

protocol ArchivePresentable: Presentable {
    var listener: ArchivePresentableListener? { get set }
}

final class ArchiveInteractor: PresentableInteractor<ArchivePresentable>, ArchiveInteractable, ArchivePresentableListener {
    
    weak var router: ArchiveRouting?
    weak var listener: ArchiveListener?
    
    override init(presenter: ArchivePresentable) {
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
