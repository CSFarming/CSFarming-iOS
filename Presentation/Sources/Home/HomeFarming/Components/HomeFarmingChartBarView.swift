//
//  HomeFarmingChartBarView.swift
//
//
//  Created by 홍성준 on 12/20/23.
//

import UIKit
import SnapKit
import DesignKit
import BasePresentation

struct HomeFarmingChartBarViewModel {
    let score: Int
    let maxScore: Int
    let dayModel: HomeFarmingChartBarDayViewModel
}

final class HomeFarmingChartBarView: BaseView {
    
    private var barViewHeightConstraint: Constraint?
    
    private let scoreLabel = UILabel()
    private let barView = UIView()
    private let dayView = HomeFarmingChartBarDayView()
    
    func setup(model: HomeFarmingChartBarViewModel, height: CGFloat) {
        scoreLabel.text = "\(model.score)"
        dayView.setup(model: model.dayModel)
        barViewHeightConstraint?.update(offset: height * CGFloat(model.score) / CGFloat(model.maxScore))
    }
    
    override func setupLayout() {
        addSubview(dayView)
        dayView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        addSubview(barView)
        barView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(dayView.snp.top).offset(-10)
            make.width.equalTo(20)
            barViewHeightConstraint = make.height.equalTo(0).constraint
        }
        
        addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.bottom.equalTo(barView.snp.top).offset(-3)
        }
    }
    
    override func setupAttributes() {
        scoreLabel.textColor = .csGray5
        scoreLabel.font = .captionR
        
        barView.backgroundColor = .csBlue5
        barView.maskCornerRadius(
            cornerRadius: 8,
            cornerMask: [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        )
    }
    
}
