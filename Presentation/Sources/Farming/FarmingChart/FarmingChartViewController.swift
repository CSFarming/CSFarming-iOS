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
    func didChangeSelectedDate(_ date: Date?)
}

final class FarmingChartViewController: UIHostingController<FarmingChartView>, FarmingChartPresentable, FarmingChartViewControllable {
    
    weak var listener: FarmingChartPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .csBlue1
        rootView.listener = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingFromParent {
            listener?.didTapClose()
        }
    }
    
    func updateTitle(_ title: String) {
        rootView.updateNavigationContent(.init(
            title: title, 
            closeAction: { [weak self] in
                self?.didTapClose()
            }
        ))
    }
    
    func updateContent(_ content: FarmingChartContent) {
        rootView.updateContent(content)
    }
    
    func updateChartDescription(_ description: FarmingChartDescription?) {
        rootView.updateChartDescription(description)
    }
    
    func didTapClose() {
        listener?.didTapClose()
    }
    
}

extension FarmingChartViewController: FarmingChartViewListener {
    
    func didChangeSelectedDate(_ date: Date?) {
        listener?.didChangeSelectedDate(date)
    }
    
}
