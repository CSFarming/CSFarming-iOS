//
//  FarmingHomeCell.swift
//  
//
//  Created by 홍성준 on 12/21/23.
//

import UIKit
import SnapKit
import DesignKit
import BasePresentation

struct FarmingHomeCellModel {
    let score: Int
    let title: String
}

final class FarmingHomeCell: BaseCollectionViewCell {
    
    private let scoreLabel = UILabel()
    private let titleLabel = UILabel()
    
    func setup(model: FarmingHomeCellModel) {
        scoreLabel.text = "+\(model.score)"
        titleLabel.text = model.title
    }
    
    override func clear() {
        scoreLabel.text = nil
        titleLabel.text = nil
    }
    
    override func setupLayout() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }
        
        contentView.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(20)
            make.trailing.equalTo(titleLabel.snp.leading).offset(-20)
        }
    }
    
    override func setupAttributes() {
        backgroundColor = .csWhite
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.csBlue2.cgColor
        
        scoreLabel.textColor = .csBlack
        scoreLabel.font = .headerB
        
        titleLabel.textColor = .csBlack
        titleLabel.font = .captionSB
    }
    
}
