//
//  FarmingChartViewModel.swift
//
//
//  Created by 홍성준 on 12/28/23.
//

import Foundation

final class FarmingChartViewModel: ObservableObject {
    
    @Published var content = FarmingChartContent()
    @Published var navigationContnet = FarmingChartNavigationContent()
    @Published var chartDescription: FarmingChartDescription?
    
    func updateContent(_ content: FarmingChartContent) {
        self.content = content
    }
    
    func updateNavigationContent(_ content: FarmingChartNavigationContent) {
        self.navigationContnet = content
    }
    
    func updateChartDescription(_ description: FarmingChartDescription?) {
        self.chartDescription = description
    }
    
}

struct FarmingChartNavigationContent {
    let title: String
    let closeAction: (() -> Void)?
    
    init(title: String = "", closeAction: (() -> Void)? = nil) {
        self.title = title
        self.closeAction = closeAction
    }
}
