//
//  QuestionCreateQuestionContentView.swift
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

final class QuestionCreateQuestionContentView: BaseView {
    
    private let titleLabel = UILabel()
    fileprivate let questionFiledView = QuestionFieldView()
    fileprivate let answerFieldView = QuestionFieldView()
    
    private let disposeBag = DisposeBag()
    
    @discardableResult
    override func becomeFirstResponder() -> Bool {
        questionFiledView.becomeFirstResponder()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        bind()
    }
    
    
    func updateTitle(_ title: String) {
        titleLabel.text = title
    }
    
    override func setupLayout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        addSubview(questionFiledView)
        questionFiledView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        addSubview(answerFieldView)
        answerFieldView.snp.makeConstraints { make in
            make.top.equalTo(questionFiledView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        titleLabel.textColor = .csBlack
        titleLabel.font = .bodySB
        
        questionFiledView.setup(model: .init(placeholder: "질문을 입력하세요"))
        answerFieldView.setup(model: .init(placeholder: "답변을 입력하세요"))
    }
    
    private func bind() {
        questionFiledView.rx.returnDidTap
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                with: self,
                onNext: { this, _ in this.answerFieldView.becomeFirstResponder() }
            )
            .disposed(by: disposeBag)
    }
    
}

extension Reactive where Base: QuestionCreateQuestionContentView {
    
    var question: ControlEvent<String?> {
        let source = base.questionFiledView.rx.text
        return ControlEvent(events: source)
    }
    
    var answer: ControlEvent<String?> {
        let source = base.answerFieldView.rx.text
        return ControlEvent(events: source)
    }
    
    var returnKeyDidTap: ControlEvent<Void> {
        let source = base.answerFieldView.rx.returnDidTap
        return ControlEvent(events: source)
    }
    
}
