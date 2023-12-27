//
//  FarmingHomeChartCell.swift
//
//
//  Created by 홍성준 on 12/27/23.
//

import UIKit
import SnapKit
import DesignKit
import BasePresentation

struct FarmingHomeChartCellModel {
    let title: String
    let description: String
}

final class FarmingHomeChartCell: AnimateCollectionViewCell {
    
    private let chartImageView = UIImageView()
    private let contentStackView = UIStackView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    func setup(model: FarmingHomeChartCellModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
    }
    
    override func setupLayout() {
        contentView.addSubview(chartImageView)
        chartImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.size.equalTo(40)
        }
        
        contentView.addSubview(contentStackView)
        contentStackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview().inset(20)
            make.leading.equalTo(chartImageView.snp.trailing).offset(20)
        }
        
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(descriptionLabel)
    }
    
    override func setupAttributes() {
        backgroundColor = .csWhite
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.csBlue2.cgColor
        
        chartImageView.image = UIImage(systemName: "chart.line.uptrend.xyaxis.circle.fill")?.withRenderingMode(.alwaysTemplate)
        chartImageView.tintColor = .csBlue5
        chartImageView.contentMode = .scaleAspectFit
        
        contentStackView.axis = .vertical
        contentStackView.spacing = 3
        contentStackView.alignment = .leading
        contentStackView.distribution = .fill
        
        titleLabel.textColor = .csBlack
        titleLabel.font = .bodySB
        
        descriptionLabel.textColor = .csBlack
        descriptionLabel.font = .captionR
        descriptionLabel.numberOfLines = 0
    }
    
}
