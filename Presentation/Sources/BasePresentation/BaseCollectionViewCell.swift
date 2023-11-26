//
//  BaseCollectionViewCell.swift
//
//
//  Created by 홍성준 on 11/26/23.
//

import UIKit

open class BaseCollectionViewCell: UICollectionViewCell {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupAttributes()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
        setupAttributes()
    }
    
    open func setupLayout() {}
    open func setupAttributes() {}
    
}
