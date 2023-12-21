//
//  HomeFarmingEmptyChartContentView.swift
//
//
//  Created by 홍성준 on 12/21/23.
//

import UIKit
import SnapKit
import DesignKit
import BasePresentation

final class HomeFarmingEmptyChartContentView: BaseView {
    
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    
    override func setupLayout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        titleLabel.text = "파밍 활동이 없어요"
        titleLabel.textColor = .csBlack
        titleLabel.font = .bodySB
        titleLabel.textAlignment = .center
        
        contentLabel.text = "글을 읽거나 학습을 통해 파밍을 할 수 있어요"
        contentLabel.textColor = .csGray5
        contentLabel.font = .bodyR
        contentLabel.numberOfLines = 0
        contentLabel.textAlignment = .center
        contentLabel.lineBreakStrategy = .hangulWordPriority
    }
    
}
