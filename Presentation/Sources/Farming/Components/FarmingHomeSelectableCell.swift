//
//  FarmingHomeSelectableCell.swift
//
//
//  Created by 홍성준 on 12/21/23.
//

import UIKit
import SnapKit
import DesignKit
import BasePresentation

struct FarmingHomeSelectableCellModel {
    let score: Int
    let title: String
    let date: String
}

final class FarmingHomeSelectableCell: AnimateCollectionViewCell {
    
    private let scoreLabel = UILabel()
    private let contentStackView = UIStackView()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let arrowImageView = UIImageView()
    
    func setup(model: FarmingHomeSelectableCellModel) {
        scoreLabel.text = "+\(model.score)"
        titleLabel.text = model.title
        dateLabel.text = model.date
    }
    
    override func clear() {
        scoreLabel.text = nil
        titleLabel.text = nil
        dateLabel.text = nil
    }
    
    override func setupLayout() {
        contentView.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        contentView.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            make.size.equalTo(20)
        }
        
        contentView.addSubview(contentStackView)
        contentStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
            make.leading.equalTo(scoreLabel.snp.trailing).offset(20)
            make.trailing.equalTo(arrowImageView.snp.leading).offset(-20)
        }
        
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(dateLabel)
    }
    
    override func setupAttributes() {
        backgroundColor = .csWhite
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.csBlue2.cgColor
        
        scoreLabel.textColor = .csBlack
        scoreLabel.font = .headerB
        
        contentStackView.axis = .vertical
        contentStackView.spacing = 3
        contentStackView.alignment = .leading
        contentStackView.distribution = .fill
        
        titleLabel.textColor = .csBlack
        titleLabel.font = .captionSB
        
        dateLabel.textColor = .csGray5
        dateLabel.font = .smallR
        
        arrowImageView.image = UIImage(systemName: "chevron.forward")?.withRenderingMode(.alwaysTemplate)
        arrowImageView.tintColor = .csGray5
        arrowImageView.contentMode = .scaleAspectFit
    }
    
}
