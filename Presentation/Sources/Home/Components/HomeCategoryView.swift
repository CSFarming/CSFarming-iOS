//
//  HomeCategoryView.swift
//
//
//  Created by 홍성준 on 11/26/23.
//

import UIKit
import SnapKit
import DesignKit
import BasePresentation

final class HomeCategoryView: BaseView {
    
    var title: String? = nil {
        didSet { titleLabel.text = title }
    }
    
    private let titleLabel = UILabel()
    
    override func setupLayout() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
        }
    }
    
    override func setupAttributes() {
        backgroundColor = .csBlue5
        
        titleLabel.font = .smallSB
        titleLabel.textColor = .csWhite
        titleLabel.textAlignment = .center
    }
    
}
