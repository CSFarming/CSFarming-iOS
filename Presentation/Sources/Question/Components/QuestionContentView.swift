//
//  QuestionContentView.swift
//
//
//  Created by 홍성준 on 12/9/23.
//

import UIKit
import BasePresentation

struct QuestionContentViewModel {
    let title: String
    let question: String
}

final class QuestionContentView: BaseView {
    
    private let titleLabel = UILabel()
    private let questionContainerView = UIView()
    private let questionLabel = UILabel()
    
    func setup(model: QuestionContentViewModel) {
        titleLabel.text = model.title
        questionLabel.text = model.question
    }
    
    override func setupLayout() {
        addSubview(titleLabel)
        addSubview(questionContainerView)
        questionContainerView.addSubview(questionLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        questionContainerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview().inset(20)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }
    }
    
    override func setupAttributes() {
        backgroundColor = .csBlue1
        
        titleLabel.textColor = .csBlack
        titleLabel.font = .largeSB
        titleLabel.textAlignment = .center
        
        questionContainerView.backgroundColor = .csWhite
        questionContainerView.layer.cornerRadius = 16
        
        questionLabel.textColor = .csBlack
        questionLabel.font = .bodyR
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .center
    }
    
}
