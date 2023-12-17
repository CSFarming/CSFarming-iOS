//
//  ProblemCreateContentView.swift
//
//
//  Created by 홍성준 on 12/17/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import DesignKit
import BasePresentation

struct ProblemCreateContentViewModel {
    let title: String
    let description: String
}

final class ProblemCreateContentView: BaseView {
    
    fileprivate var tap: ControlEvent<Void> {
        createButton.rx.tap
    }
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let createButton = ActionButton()
    
    func setup(model: ProblemCreateContentViewModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
    }
    
    override func setupLayout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(20)
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        addSubview(createButton)
        createButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
    }
    
    override func setupAttributes() {
        backgroundColor = .csWhite
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.csBlue2.cgColor
        
        titleLabel.font = .bodySB
        titleLabel.textColor = .csBlack
        titleLabel.numberOfLines = 0
        
        descriptionLabel.font = .bodyR
        descriptionLabel.textColor = .csGray5
        descriptionLabel.numberOfLines = 0
        
        createButton.style = .normal
        createButton.setTitle("추가하기", for: .normal)
        createButton.layer.cornerRadius = 8
    }
    
}

extension Reactive where Base: ProblemCreateContentView {
    
    var createTap: ControlEvent<Void> {
        let source = base.tap
        return ControlEvent(events: source)
    }
    
}
