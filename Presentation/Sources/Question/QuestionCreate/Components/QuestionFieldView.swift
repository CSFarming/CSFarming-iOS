//
//  QuestionFieldView.swift
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

struct QuestionFieldViewModel {
    let placeholder: String
}

final class QuestionFieldView: BaseView {
    
    fileprivate var textProperty: ControlProperty<String?> {
        return textField.rx.text
    }
    
    fileprivate var clearButtonDidTap: ControlEvent<Void> {
        return clearButton.rx.tap
    }
    
    fileprivate var returnKeyDidTap: ControlEvent<Void> {
        return textField.rx.controlEvent(.editingDidEndOnExit)
    }
    
    @discardableResult
    override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }
    
    private let textField = BaseTextField()
    private let clearButton = UIButton()
    private let disposeBag = DisposeBag()
    
    func setup(model: QuestionFieldViewModel) {
        textField.placeholder = model.placeholder
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        bind()
    }
    
    override func setupLayout() {
        addSubview(clearButton)
        clearButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(15)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalTo(clearButton.snp.leading)
            make.height.equalTo(22)
        }
    }
    
    override func setupAttributes() {
        backgroundColor = .csWhite
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.csBlue2.cgColor
        
        textField.backgroundColor = .csWhite
        textField.textColor = .csBlack
        
        clearButton.setImage(
            UIImage(systemName: "xmark.circle.fill")?.withRenderingMode(.alwaysTemplate),
            for: .normal
        )
        clearButton.tintColor = .csGray3
        clearButton.isHidden = true
        clearButton.contentMode = .center
    }
    
    private func bind() {
        textField.rx.text
            .compactMap { $0 }
            .map { $0.isEmpty }
            .bind(to: clearHiddenBinder)
            .disposed(by: disposeBag)
        
        clearButton.rx.tap
            .bind(to: clearBinder)
            .disposed(by: disposeBag)
    }
    
    private var clearHiddenBinder: Binder<Bool> {
        return Binder(self) { this, isEmpty in
            this.clearButton.isHidden = isEmpty
        }
    }
    
    private var clearBinder: Binder<Void> {
        return Binder(self) { this, _ in
            this.textField.text = ""
            this.textField.sendActions(for: .valueChanged)
        }
    }
    
}

extension Reactive where Base: QuestionFieldView {
    
    var text: ControlEvent<String?> {
        let source = base.textProperty
        return ControlEvent(events: source)
    }
    
    var clearDidTap: ControlEvent<Void> {
        let source = base.clearButtonDidTap
        return ControlEvent(events: source)
    }
    
    var returnDidTap: ControlEvent<Void> {
        let source = base.returnKeyDidTap
        return ControlEvent(events: source)
    }
    
}
