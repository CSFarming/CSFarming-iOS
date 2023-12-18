//
//  QuestionCreateCompleteViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/18/23.
//

import RIBs
import RxSwift
import UIKit
import SnapKit
import DesignKit
import BasePresentation
import QuestionService

protocol QuestionCreateCompletePresentableListener: AnyObject {
    func didTapClose()
    func didTapCreate()
    func didTapShare()
}

final class QuestionCreateCompleteViewController: BaseViewController, QuestionCreateCompletePresentable, QuestionCreateCompleteViewControllable {
    
    weak var listener: QuestionCreateCompletePresentableListener?
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    private let buttonStackView = UIStackView()
    private let shareButton = ActionButton()
    private let createButton = ActionButton()
    
    private let descriptionLabel = UILabel()
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    func setup(title: String, subtitle: String, questions: [Question]) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        
        questions.forEach { question in
            let questionView = QuestionCreateCompleteQuestionView()
            questionView.setup(question: question)
            stackView.addArrangedSubview(questionView)
        }
    }
    
    override func setupLayout() {
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        view.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        buttonStackView.addArrangedSubview(createButton)
        buttonStackView.addArrangedSubview(shareButton)
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(buttonStackView.snp.top)
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        view.backgroundColor = .csBlue1
        
        navigationView.updateTitle("Q&A 추가 결과")
        navigationView.setup(model: .init(leftButtonType: .back, rightButtonType: .none))
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInset = .init(top: 20, left: 0, bottom: 50, right: 0)
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.setCustomSpacing(30, after: descriptionLabel)
        stackView.setCustomSpacing(10, after: titleLabel)
        
        buttonStackView.axis = .horizontal
        buttonStackView.alignment = .fill
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 20
        
        createButton.style = .secondary
        createButton.setTitle("저장하기", for: .normal)
        createButton.layer.cornerRadius = 16
        
        shareButton.style = .normal
        shareButton.setTitle("공유하기", for: .normal)
        shareButton.layer.cornerRadius = 16
        
        descriptionLabel.text = "내용을 확인해주세요"
        descriptionLabel.textColor = .csBlack
        descriptionLabel.font = .largeSB
        descriptionLabel.numberOfLines = 0
        
        titleLabel.textColor = .csBlack
        titleLabel.font = .bodySB
        titleLabel.numberOfLines = 0
        
        subtitleLabel.textColor = .csGray5
        subtitleLabel.font = .bodyR
        subtitleLabel.numberOfLines = 0
    }
    
    override func bind() {
        navigationView.rx.leftButtonDidTap
            .bind(to: closeBinder)
            .disposed(by: disposeBag)
        
        createButton.rx.tap
            .bind(to: createBinder)
            .disposed(by: disposeBag)
        
        shareButton.rx.tap
            .bind(to: shareBinder)
            .disposed(by: disposeBag)
    }
    
    private var closeBinder: Binder<Void> {
        return Binder(self) { this, _ in
            this.listener?.didTapClose()
        }
    }
    
    private var createBinder: Binder<Void> {
        return Binder(self) { this, _ in
            this.listener?.didTapCreate()
        }
    }
    
    private var shareBinder: Binder<Void> {
        return Binder(self) { this, _ in
            this.listener?.didTapShare()
        }
    }
    
}
