//
//  QuestionCreateContentView.swift
//
//
//  Created by 홍성준 on 12/17/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import DesignKit
import BasePresentation

struct QuestionCreateContentViewModel {
    let title: String
    let placeholder: String
}

final class QuestionCreateContentView: BaseView {
    
    private let titleLabel = UILabel()
    fileprivate let fieldView = QuestionFieldView()
    
    @discardableResult
    override func becomeFirstResponder() -> Bool {
        fieldView.becomeFirstResponder()
    }
    
    func setup(model: QuestionCreateContentViewModel) {
        titleLabel.text = model.title
        fieldView.setup(model: .init(placeholder: model.placeholder))
    }
    
    override func setupLayout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        addSubview(fieldView)
        fieldView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        titleLabel.textColor = .csBlack
        titleLabel.font = .bodySB
    }
    
}

extension Reactive where Base: QuestionCreateContentView {
    
    var text: ControlEvent<String?> {
        let source = base.fieldView.rx.text
        return ControlEvent(events: source)
    }
    
    var returnKeyDidTap: ControlEvent<Void> {
        let source = base.fieldView.rx.returnDidTap
        return ControlEvent(events: source)
    }
    
}
