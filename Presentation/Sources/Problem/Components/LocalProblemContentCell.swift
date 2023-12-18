//
//  LocalProblemContentCell.swift
//
//
//  Created by 홍성준 on 12/18/23.
//

import UIKit
import SnapKit
import DesignKit
import BasePresentation

struct LocalProblemContentCellModel {
    let title: String
    let subtitle: String
}

final class LocalProblemContentCell: AnimateCollectionViewCell {
    
    private let docsImageView = UIImageView()
    private let labelStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    func setup(model: LocalProblemContentCellModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
    }
    
    override func setupLayout() {
        contentView.addSubview(docsImageView)
        contentView.addSubview(labelStackView)
        
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(subtitleLabel)
        
        docsImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        labelStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(docsImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    override func setupAttributes() {
        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.csBlue2.cgColor
        
        docsImageView.image = UIImage(systemName: "doc.text")?.withRenderingMode(.alwaysTemplate)
        docsImageView.contentMode = .scaleAspectFit
        docsImageView.tintColor = .csBlue5
        
        labelStackView.axis = .vertical
        labelStackView.spacing = 3
        labelStackView.alignment = .fill
        labelStackView.distribution = .fill
        
        titleLabel.textColor = .csBlack
        titleLabel.font = .bodySB
        
        subtitleLabel.textColor = .csBlack
        subtitleLabel.font = .captionR
    }
    
}
