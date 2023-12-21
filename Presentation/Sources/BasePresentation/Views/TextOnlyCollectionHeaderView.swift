//
//  TextOnlyCollectionHeaderView.swift
//
//
//  Created by 홍성준 on 12/22/23.
//

import UIKit
import SnapKit
import DesignKit

open class TextOnlyCollectionHeaderView: BaseCollectionReusableView {
    
    private let titleLabel = UILabel()
    
    public func updateTitle(_ title: String) {
        titleLabel.text = title
    }
    
    open override func clear() {
        titleLabel.text = nil
    }
    
    open override func setupLayout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    open override func setupAttributes() {
        titleLabel.textColor = .csBlack
        titleLabel.font = .largeB
    }
    
}
