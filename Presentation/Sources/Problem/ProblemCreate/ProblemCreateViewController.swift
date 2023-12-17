//
//  ProblemCreateViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/17/23.
//

import RIBs
import RxSwift
import UIKit
import DesignKit
import BasePresentation

protocol ProblemCreatePresentableListener: AnyObject {
    func didTapClose()
    func didTapQuestion()
}

final class ProblemCreateViewController: BaseViewController, ProblemCreatePresentable, ProblemCreateViewControllable {
    
    weak var listener: ProblemCreatePresentableListener?
    
    private let stackView = UIStackView()
    private let questionView = ProblemCreateContentView()
    
    override func setupLayout() {
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        stackView.addArrangedSubview(questionView)
    }
    
    override func setupAttributes() {
        view.backgroundColor = .csBlue1
        
        navigationView.setup(model: .init(
            leftButtonType: .close,
            rightButtonType: .none
        ))
        navigationView.updateTitle("문제 추가")
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 15
        
        questionView.setup(model: .init(
            title: "Q&A 문제",
            description: "질문/답변 형태의 문제를 추가할 수 있습니다"
        ))
    }
    
    override func bind() {
        navigationView.rx.leftButtonDidTap
            .bind(to: closeBinder)
            .disposed(by: disposeBag)
        
        questionView.rx.createTap
            .bind(to: questionCreateBinder)
            .disposed(by: disposeBag)
        
    }
    
    private var closeBinder: Binder<Void> {
        return Binder(self) { this, _ in
            this.listener?.didTapClose()
        }
    }
    
    private var questionCreateBinder: Binder<Void> {
        return Binder(self) { this, _ in
            this.listener?.didTapQuestion()
        }
    }
    
}
