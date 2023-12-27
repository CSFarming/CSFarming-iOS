//
//  FarmingChartViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/26/23.
//

import RIBs
import RxSwift
import UIKit
import SwiftUI
import DesignKit
import BasePresentation

protocol FarmingChartPresentableListener: AnyObject {
    func didTapClose()
}

final class FarmingChartViewController: UIHostingController<FarmingChartView>, FarmingChartPresentable, FarmingChartViewControllable {
    
    weak var listener: FarmingChartPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .csBlue1
        rootView.updateCloseAction { [weak self] in
            self?.didTapClose()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingFromParent {
            listener?.didTapClose()
        }
    }
    
    func updateChartGroups(_ groups: [FarmingChartGroup]) {
        rootView.updateGroups(groups)
    }
    
    func updateDescription(_ description: String) {
        rootView.updateDescription(description)
    }
    
    func updateTitle(_ title: String) {
        rootView.updateTitle(title)
    }
    
    func didTapClose() {
        listener?.didTapClose()
    }
    
}
