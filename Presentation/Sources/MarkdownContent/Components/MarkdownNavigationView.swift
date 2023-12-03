//
//  MarkdownNavigationView.swift
//  
//
//  Created by 홍성준 on 12/3/23.
//

import SwiftUI
import DesignKit

struct MarkdownNavigationView: UIViewRepresentable {
    
    @State var title: String
    @State var action: (() -> Void)?
    
    func makeUIView(context: Context) -> DesignKit.NavigationView {
        let view = DesignKit.NavigationView()
        view.setup(model: .init(leftButtonType: .back, rightButtonType: .none))
        return view
    }
    
    func updateUIView(_ uiView: DesignKit.NavigationView, context: Context) {
        uiView.updateTitle(title)
        context.coordinator.addAction(button: uiView.leftButton, action: action)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator {
        
        private var action: (() -> Void)?
        
        func addAction(button: UIButton, action: (() -> Void)?) {
            self.action = action
            button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        }
        
        @objc private func didTap() {
            action?()
        }
        
    }
    
}
