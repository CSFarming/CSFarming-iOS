//
//  FarmingQuestionCell.swift
//
//
//  Created by 홍성준 on 12/23/23.
//

import UIKit
import SnapKit
import DesignKit
import BasePresentation

struct FarmingQuestionCellModel {
    let question: String
    let answer: String
    let isOpened: Bool
}

final class FarmingQuestionCell: AnimateCollectionViewCell {
    
    private let questionLabel = UILabel()
    private let toggleImageView = UIImageView()
    private let separator = UIView()
    private let answerLabel = UILabel()
    
    private var toggleImageViewBottomConstraint: Constraint?
    private var answerLabelBottomConstraint: Constraint?
    
    func setup(model: FarmingQuestionCellModel) {
        questionLabel.text = model.question
        answerLabel.text = model.answer
        updateLayout(isOpened: model.isOpened)
    }
    
    private func updateLayout(isOpened: Bool) {
        toggleImageViewBottomConstraint?.isActive = !isOpened
        toggleImageView.isHidden = isOpened
        answerLabelBottomConstraint?.isActive = isOpened
        separator.isHidden = !isOpened
        answerLabel.isHidden = !isOpened
    }
    
    override func clear() {
        questionLabel.text = nil
        answerLabel.text = nil
        updateLayout(isOpened: false)
    }
    
    override func setupLayout() {
        contentView.addSubview(questionLabel)
        questionLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(20)
        }
        
        contentView.addSubview(toggleImageView)
        toggleImageView.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(20)
            toggleImageViewBottomConstraint = make.bottom.equalToSuperview().offset(-20).constraint
            toggleImageViewBottomConstraint?.isActive = true
        }
        
        contentView.addSubview(separator)
        separator.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        contentView.addSubview(answerLabel)
        answerLabel.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            answerLabelBottomConstraint = make.bottom.equalToSuperview().offset(-20).constraint
            answerLabelBottomConstraint?.isActive = false
        }
    }
    
    override func setupAttributes() {
        backgroundColor = .csWhite
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.csBlue2.cgColor
        
        questionLabel.textColor = .csBlack
        questionLabel.font = .bodySB
        questionLabel.numberOfLines = 0
        
        toggleImageView.image = UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysTemplate)
        toggleImageView.contentMode = .scaleAspectFit
        toggleImageView.tintColor = .csBlack
        
        separator.backgroundColor = .csGray2
        separator.isHidden = true
        
        answerLabel.textColor = .csBlack
        answerLabel.font = .bodyR
        answerLabel.numberOfLines = 0
        answerLabel.isHidden = true
    }
    
}
