//
//  ProblemListCell.swift
//
//
//  Created by 홍성준 on 12/9/23.
//

import UIKit
import SnapKit
import DesignKit
import BasePresentation

struct ProblemListCellModel {
    
    let title: String
    let content: String
    let type: ProblemListCellType
    
}

enum ProblemListCellType {
    case folder
    case file
    
    var imageName: String {
        switch self {
        case .folder: return "folder.fill"
        case .file: return "doc.text"
        }
    }
}

final class ProblemListCell: AnimateCollectionViewCell {
    
    private let containerView = UIView()
    private let iconImageView = UIImageView()
    private let labelStackView = UIStackView()
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        titleLabel.text = nil
        contentLabel.text = nil
    }
    
    func setup(model: ProblemListCellModel) {
        titleLabel.text = model.title
        contentLabel.text = model.content
        iconImageView.image = UIImage(systemName: model.type.imageName)?.withRenderingMode(.alwaysTemplate)
    }
    
    override func setupLayout() {
        contentView.addSubview(containerView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(labelStackView)
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(contentLabel)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 10, right: 20))
        }
        
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    override func setupAttributes() {
        backgroundColor = .csBlue1
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 20
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.csBlue2.cgColor
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .csBlue5
        
        labelStackView.axis = .vertical
        labelStackView.spacing = 5
        labelStackView.alignment = .fill
        labelStackView.distribution = .fill
        
        titleLabel.font = .bodySB
        titleLabel.textColor = .csBlack
        
        contentLabel.font = .captionR
        contentLabel.textColor = .csBlack
    }
    
}
