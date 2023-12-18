//
//  ProblemHeader.swift
//
//
//  Created by 홍성준 on 12/18/23.
//

import UIKit
import SnapKit
import DesignKit
import BasePresentation

final class ProblemHeader: BaseCollectionReusableView {
    
    private let titleLabel = UILabel()
    
    func updateTitle(_ title: String) {
        titleLabel.text = title
    }
    
    override func clear() {
        titleLabel.text = nil
    }
    
    override func setupLayout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        titleLabel.textColor = .csBlack
        titleLabel.font = .headerSB
    }
    
}
