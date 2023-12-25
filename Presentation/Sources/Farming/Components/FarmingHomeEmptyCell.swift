//
//  FarmingHomeEmptyCell.swift
//
//
//  Created by 홍성준 on 12/25/23.
//

import UIKit
import SnapKit
import DesignKit
import BasePresentation

final class FarmingHomeEmptyCell: BaseCollectionViewCell {
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    override func setupLayout() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(20)
        }
        
        contentView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview().inset(20)
        }
    }
    
    override func setupAttributes() {
        backgroundColor = .csWhite
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.csBlue2.cgColor
        
        titleLabel.text = "파밍 내역이 없어요"
        titleLabel.textColor = .csBlack
        titleLabel.font = .bodySB
        titleLabel.textAlignment = .center
        
        subtitleLabel.text = "학습이나 문제 풀이를 통해 파밍을 해보세요"
        subtitleLabel.textColor = .csBlack
        subtitleLabel.font = .bodyR
        subtitleLabel.textAlignment = .center
    }
    
}
