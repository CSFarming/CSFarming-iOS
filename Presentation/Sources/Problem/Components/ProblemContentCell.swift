//
//  ProblemContentCell.swift
//
//
//  Created by 홍성준 on 12/18/23.
//

import UIKit
import SnapKit
import DesignKit
import BasePresentation

struct ProblemContentCellModel {
    
    let title: String
    let content: String
    
}

final class ProblemContentCell: AnimateCollectionViewCell {
    
    private let folderImageView = UIImageView()
    private let labelStackView = UIStackView()
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    
    func setup(model: ProblemContentCellModel) {
        titleLabel.text = model.title
        contentLabel.text = model.content
    }
    
    override func setupLayout() {
        contentView.addSubview(folderImageView)
        contentView.addSubview(labelStackView)
        
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(contentLabel)
        
        folderImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        labelStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(folderImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    override func setupAttributes() {
        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.csBlue2.cgColor
        
        folderImageView.image = UIImage(systemName: "folder.fill")?.withRenderingMode(.alwaysTemplate)
        folderImageView.contentMode = .scaleAspectFit
        folderImageView.tintColor = .csBlue5
        
        labelStackView.axis = .vertical
        labelStackView.spacing = 3
        labelStackView.alignment = .fill
        labelStackView.distribution = .fill
        
        titleLabel.textColor = .csBlack
        titleLabel.font = .bodySB
        
        contentLabel.textColor = .csBlack
        contentLabel.font = .captionR
    }
    
}
