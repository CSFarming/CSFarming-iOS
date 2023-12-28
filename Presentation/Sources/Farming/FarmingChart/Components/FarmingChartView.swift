//
//  FarmingChartView.swift
//
//
//  Created by 홍성준 on 12/26/23.
//

import SwiftUI
import Charts
import DesignKit

protocol FarmingChartViewListener: AnyObject {
    func didChangeSelectedDate(_ date: Date?)
}

struct FarmingChartView: View {
    
    weak var listener: FarmingChartViewListener?
    
    @ObservedObject var viewModel: FarmingChartViewModel = FarmingChartViewModel()
    @State private var rawSelectedDate: Date? = nil
    
    func updateContent(_ content: FarmingChartContent) {
        viewModel.updateContent(content)
    }
    
    func updateNavigationContent(_ content: FarmingChartNavigationContent) {
        viewModel.updateNavigationContent(content)
    }
    
    func updateChartDescription(_ description: FarmingChartDescription?) {
        viewModel.updateChartDescription(description)
    }
    
    var title: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("문제 파밍 통계")
                .font(Font(UIFont.bodySB))
                .foregroundStyle(Color(UIColor.csBlack))
            Text("최근 7일 동안 풀었던 문제 통계에요")
                .font(Font(UIFont.captionR))
                .foregroundStyle(Color(UIColor.csGray5))
        }
    }
    
    var body: some View {
        FarmingChartNavigationView(
            title: viewModel.navigationContnet.title,
            action: viewModel.navigationContnet.closeAction
        )
        .frame(height: 50)
        .background(Color(UIColor.csBlue1))
        
        List {
            title
                .opacity(viewModel.chartDescription == nil ? 1.0 : 0.0)
                .listRowBackground(Color(UIColor.csBlue1))
            
            FarmingChartContentView(rawSelectedDate: $rawSelectedDate)
                .environmentObject(viewModel)
                .frame(height: 300)
                .padding(.top, 10)
                .padding(.horizontal, 20)
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .listRowBackground(Color(UIColor.csBlue1))
                .onChange(of: rawSelectedDate, { _, date in
                    listener?.didChangeSelectedDate(date)
                })
            
            FarmingChartDescriptionView(description: viewModel.content.description)
                .listRowInsets(EdgeInsets())
                .padding([.top, .leading, .trailing], 20)
                .listRowSeparator(.hidden)
                .listRowBackground(Color(UIColor.csBlue1))
        }
        .listStyle(PlainListStyle())
        .scrollDisabled(true)
    }
    
}

private struct FarmingChartDescriptionView: View {
    
    fileprivate let description: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(UIColor.csWhite))
                .stroke(Color(UIColor.csBlue2), lineWidth: 1)
            
            Text(description)
                .padding(.vertical, 15)
                .padding(.horizontal, 20)
                .font(Font(UIFont.bodyR))
        }
    }
    
}
