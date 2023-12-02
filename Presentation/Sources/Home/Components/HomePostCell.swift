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
    let type: HomePostCellType
    
}

enum HomePostCellType {
    case folder
    case file
    
    var imageName: String {
        switch self {
        case .folder: "folder.fill"
        case .file: "doc"
        }
    }
}

final class HomePostCell: BaseTableViewCell {
    
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let iconImageView = UIImageView()
    
    func setup(model: HomePostCellModel) {
        titleLabel.text = model.title
        iconImageView.image = UIImage(systemName: model.type.imageName)?.withRenderingMode(.alwaysTemplate)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        selectAnimate()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        iconImageView.image = nil
    }
    
    override func setupLayout() {
        contentView.addSubview(containerView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 10, right: 20))
        }
        
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    override func setupAttributes() {
        selectionStyle = .none
        backgroundColor = .csBlue1
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 20
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.csBlue2.cgColor
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .csBlue5
        
        titleLabel.font = .bodySB
        titleLabel.textColor = .csBlack
    }
    
}
