//
//  HomeRecentProblemView.swift
//
//
//  Created by 홍성준 on 12/20/23.
//

import UIKit
import SnapKit
import DesignKit
import BasePresentation

struct HomeRecentProblemViewModel {
    
    let title: String
    let subtitle: String
    let progressContent: String
    
}

final class HomeRecentProblemView: AnimateBaseView {
    
    private let labelStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let iconImageView = UIImageView()
    private let progreeView = HomeCategoryView()
    
    func setup(model: HomeRecentProblemViewModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        progreeView.title = model.progressContent
    }
    
    override func setupLayout() {
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        addSubview(progreeView)
        progreeView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        addSubview(labelStackView)
        labelStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.trailing.lessThanOrEqualTo(progreeView.snp.leading).offset(-10)
        }
        
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(subtitleLabel)
    }
    
    override func setupAttributes() {
        backgroundColor = .csWhite
        layer.cornerRadius = 20
        layer.borderWidth = 1
        layer.borderColor = UIColor.csBlue2.cgColor
        
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
