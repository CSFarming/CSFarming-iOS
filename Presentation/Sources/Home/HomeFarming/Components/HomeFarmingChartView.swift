//
//  HomeFarmingChartView.swift
//
//
//  Created by 홍성준 on 12/20/23.
//

import UIKit
import SnapKit
import DesignKit
import BasePresentation

struct HomeFarmingChartViewModel {
    let barModels: [HomeFarmingChartBarViewModel]
}

final class HomeFarmingChartView: AnimateBaseView {
    
    private let containerView = UIView()
    private let stackView = UIStackView()
    
    func setup(model: HomeFarmingChartViewModel, height: CGFloat) {
        stackView.subviews.forEach { $0.removeFromSuperview() }
        
        model.barModels.forEach { barModel in
            let barView = HomeFarmingChartBarView()
            barView.setup(model: barModel, height: height)
            stackView.addArrangedSubview(barView)
        }
    }
    
    override func setupLayout() {
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }
    }
    
    override func setupAttributes() {
        backgroundColor = .clear
        
        containerView.backgroundColor = .csWhite
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.csBlue2.cgColor
        containerView.layer.cornerRadius = 16
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .bottom
    }
    
}
