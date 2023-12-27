//
//  FarmingChartView.swift
//
//
//  Created by 홍성준 on 12/26/23.
//

import SwiftUI
import Charts
import DesignKit

struct FarmingChartView: View {
    
    @ObservedObject private var content = FarmingChartContent()
    
    func updateTitle(_ title: String) {
        content.title = title
    }
    
    func updateDescription(_ description: String) {
        content.description = description
    }
    
    func updateGroups(_ groups: [FarmingChartGroup]) {
        content.groups = groups
    }
    
    func updateCloseAction(_ action: (() -> Void)?) {
        content.closeAction = action
    }
    
    var body: some View {
        FarmingChartNavigationView(
            title: content.title,
            action: content.closeAction
        )
        .frame(height: 50)
        .background(Color(UIColor.csBlue1))
        
        List {
            FarmingChartContentView()
                .environmentObject(content)
                .frame(height: 300)
                .padding([.top, .leading, .trailing], 20)
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .listRowBackground(Color(UIColor.csBlue1))
            
            FarmingChartDescriptionView(description: content.description)
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
