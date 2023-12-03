//
//  HomePostCell.swift
//
//
//  Created by 홍성준 on 11/26/23.
//

import UIKit
import SnapKit
import DesignKit
import BasePresentation

struct HomePostCellModel {
    
    let title: String
    let category: String
    let visitied: String
    
}

final class HomePostCell: AnimateTableViewCell {
    
    private let containerView = UIView()
    private let categoryView = HomeCategoryView()
    private let titleLabel = UILabel()
    private let visitedLabel = UILabel()
    
    func setup(model: HomePostCellModel) {
        titleLabel.text = model.title
        categoryView.title = model.category
        visitedLabel.text = model.visitied
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        categoryView.title = nil
        visitedLabel.text = nil
    }
    
    override func setupLayout() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(categoryView)
        containerView.addSubview(visitedLabel)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 10, right: 20))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(20)
        }
        
        categoryView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.bottom.equalToSuperview().inset(20)
        }
        
        visitedLabel.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(20)
        }
    }
    
    override func setupAttributes() {
        selectionStyle = .none
        backgroundColor = .csBlue1
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 20
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.csBlue2.cgColor
        
        categoryView.layer.cornerRadius = 8
        
        titleLabel.font = .bodySB
        titleLabel.textColor = .csBlack
        
        visitedLabel.font = .smallR
        visitedLabel.textColor = .csGray4
        visitedLabel.textAlignment = .right
    }
    
}
