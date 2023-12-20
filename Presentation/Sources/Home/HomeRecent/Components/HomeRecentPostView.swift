//
//  HomeRecentPostView.swift
//
//
//  Created by 홍성준 on 12/20/23.
//

import UIKit
import SnapKit
import DesignKit
import BasePresentation

struct HomeRecentPostViewModel {
    
    let title: String
    let category: String
    let visitied: String
    
}

final class HomeRecentPostView: AnimateBaseView {
    
    private let categoryView = HomeCategoryView()
    private let titleLabel = UILabel()
    private let visitedLabel = UILabel()
    
    func setup(model: HomeRecentPostViewModel) {
        titleLabel.text = model.title
        categoryView.title = model.category
        visitedLabel.text = model.visitied
    }
    
    override func setupLayout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(20)
        }
        
        addSubview(categoryView)
        categoryView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.bottom.equalToSuperview().inset(20)
        }
        
        addSubview(visitedLabel)
        visitedLabel.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(20)
        }
    }
    
    override func setupAttributes() {
        backgroundColor = .csWhite
        layer.cornerRadius = 20
        layer.borderWidth = 1
        layer.borderColor = UIColor.csBlue2.cgColor
        
        categoryView.layer.cornerRadius = 8
        
        titleLabel.font = .bodySB
        titleLabel.textColor = .csBlack
        
        visitedLabel.font = .smallR
        visitedLabel.textColor = .csGray4
        visitedLabel.textAlignment = .right
    }
    
}
