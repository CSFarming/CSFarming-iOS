//
//  QuestionViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/9/23.
//

import UIKit
import RIBs
import RxSwift
import RxCocoa
import SnapKit
import BasePresentation
import DesignKit

struct QuestionViewControllerModel {
    let title: String
    let question: String
    let progress: Float
}

protocol QuestionPresentableListener: AnyObject {
    func didTapClose()
    func didTapOK()
    func didTapPass()
}

final class QuestionViewController: BaseViewController, QuestionPresentable, QuestionViewControllable {
    
    weak var listener: QuestionPresentableListener?
    
    private let progressView = UIProgressView()
    private let contentView = QuestionContentView()
    private let buttonStackView = UIStackView()
    private let okButton = ActionButton()
    private let passButton = ActionButton()
    
    func setup(title: String) {
        navigationView.updateTitle(title)
    }
    
    func setup(model: QuestionViewControllerModel) {
        contentView.setup(model: .init(
            title: model.title,
            question: model.question
        ))
        progressView.setProgress(model.progress, animated: true)
    }
    
    override func setupLayout() {
        view.addSubview(navigationView)
        view.addSubview(progressView)
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(passButton)
        buttonStackView.addArrangedSubview(okButton)
        view.addSubview(contentView)
        
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(buttonStackView.snp.top).offset(-20)
        }
    }
    
    override func setupAttributes() {
        view.backgroundColor = .csBlue1
        
        navigationView.setup(model: .init(
            leftButtonType: .close,
            rightButtonType: .none
        ))
        navigationView.hideSeparator()
        
        progressView.progressTintColor = .csBlue5
        progressView.backgroundColor = .csGray2
        
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 20
        buttonStackView.alignment = .fill
        
        okButton.style = .normal
        okButton.setTitle("잘 알고 있어요", for: .normal)
        okButton.layer.cornerRadius = 16
        
        passButton.style = .secondary
        passButton.setTitle("잘 모르겠어요", for: .normal)
        passButton.layer.cornerRadius = 16
    }
    
    override func bind() {
        navigationView.rx.leftButtonDidTap
            .bind(to: closeBinder)
            .disposed(by: disposeBag)
        
        okButton.rx.tap
            .bind(to: okBinder)
            .disposed(by: disposeBag)
        
        passButton.rx.tap
            .bind(to: passBinder)
            .disposed(by: disposeBag)
    }
    
    private var closeBinder: Binder<Void> {
        return Binder(self) { this, _ in
            this.listener?.didTapClose()
        }
    }
    
    private var okBinder: Binder<Void> {
        return Binder(self) { this, _ in
            this.hapticGenerator.impact(style: .medium)
            this.listener?.didTapOK()
        }
    }
    
    private var passBinder: Binder<Void> {
        return Binder(self) { this, _ in
            this.hapticGenerator.impact(style: .medium)
            this.listener?.didTapPass()
        }
    }
    
}
