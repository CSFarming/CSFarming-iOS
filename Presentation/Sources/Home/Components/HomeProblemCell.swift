//
//  HomeProblemCell.swift
//
//
//  Created by 홍성준 on 11/26/23.
//

import UIKit
import SnapKit
import DesignKit
import BasePresentation

struct HomeProblemCellModel {
    
    let title: String
    let subtitle: String
    let iconImageURL: String
    let progressContent: String
    
}

final class HomeProblemCell: BaseTableViewCell {
    
    private let containerView = UIView()
    private let labelStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let iconImageView = UIImageView()
    private let progreeView = HomeCategoryView()
    
    func setup(model: HomeProblemCellModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
//        iconImageView.image = nil
        progreeView.title = model.progressContent
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subtitleLabel.text = nil
        iconImageView.image = nil
        progreeView.title = nil
    }
    
    override func setupLayout() {
        contentView.addSubview(containerView)
        containerView.addSubview(labelStackView)
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(subtitleLabel)
        
        containerView.addSubview(iconImageView)
        containerView.addSubview(progreeView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 10, right: 20))
        }
        
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        progreeView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.trailing.lessThanOrEqualTo(progreeView.snp.leading).offset(-10)
        }
    }
    
    override func setupAttributes() {
        selectionStyle = .none
        backgroundColor = .csBlue1
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 20
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.csBlue2.cgColor
        
        labelStackView.axis = .vertical
        labelStackView.spacing = 0
        labelStackView.alignment = .fill
        labelStackView.distribution = .fillEqually
        
        iconImageView.clipsToBounds = true
        iconImageView.layer.cornerRadius = 20
        iconImageView.backgroundColor = .csBlue2
        
        titleLabel.font = .bodySB
        titleLabel.textColor = .csBlack
        
        subtitleLabel.font = .smallR
        subtitleLabel.textColor = .csBlack
        
        progreeView.layer.cornerRadius = 15
    }
    
    
}
