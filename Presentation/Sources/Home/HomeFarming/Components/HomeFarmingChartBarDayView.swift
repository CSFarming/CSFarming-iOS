//
//  HomeFarmingChartBarDayView.swift
//
//
//  Created by 홍성준 on 12/20/23.
//

import UIKit
import SnapKit
import DesignKit
import BasePresentation

struct HomeFarmingChartBarDayViewModel {
    let day: Int
    let type: HomeFarmingChartBarDayType
}

enum HomeFarmingChartBarDayType {
    case normal
    case today
    case saturday
    case sunday
}

final class HomeFarmingChartBarDayView: BaseView {
    
    private let containerView = UIView()
    private let dayLabel = UILabel()
    
    func setup(model: HomeFarmingChartBarDayViewModel) {
        dayLabel.text = "\(model.day)"
        dayLabel.textColor = model.type.dayColor
        containerView.backgroundColor = model.type.backgroundColor
        containerView.layer.borderColor = model.type.borderColor.cgColor
    }
    
    override func setupLayout() {
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        containerView.addSubview(dayLabel)
        dayLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        containerView.layer.cornerRadius = 30 / 2
        containerView.layer.borderWidth = 1
        containerView.backgroundColor = .clear
        
        dayLabel.textColor = .csBlack
        dayLabel.font = .bodySB
        dayLabel.textAlignment = .center
    }
    
}

private extension HomeFarmingChartBarDayType {
    
    var dayColor: UIColor {
        switch self {
        case .normal: return .csBlack
        case .today: return .csWhite
        case .saturday: return .csBlue5
        case .sunday: return .red
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .today: return .csBlue5
        default: return .clear
        }
    }
    
    var borderColor: UIColor {
        switch self {
        case .today: return .csBlue3
        default: return .clear
        }
    }
    
}
