//
//  QuestionCreateCompleteQuestionView.swift
//
//
//  Created by 홍성준 on 12/18/23.
//

import UIKit
import SnapKit
import DesignKit
import BasePresentation
import QuestionService

final class QuestionCreateCompleteQuestionView: BaseView {
    
    private let questionLabel = UILabel()
    private let answerLabel = UILabel()
    
    func setup(question: Question) {
        questionLabel.text = question.question
        answerLabel.text = question.answer
    }
    
    override func setupLayout() {
        addSubview(questionLabel)
        questionLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(20)
        }
        
        addSubview(answerLabel)
        answerLabel.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview().inset(20)
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
        
        answerLabel.textColor = .csGray5
        answerLabel.font = .bodyR
        answerLabel.numberOfLines = 0
    }
    
}
