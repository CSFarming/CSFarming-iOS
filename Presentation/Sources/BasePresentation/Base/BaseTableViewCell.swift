//
//  BaseTableViewCell.swift
//
//
//  Created by 홍성준 on 11/26/23.
//

import UIKit
import RxSwift

open class BaseTableViewCell: UITableViewCell {
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
