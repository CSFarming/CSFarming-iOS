//
//  QuestionCreateViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/17/23.
//

import RIBs
import RxSwift
import UIKit
import DesignKit
import BasePresentation

protocol QuestionCreatePresentableListener: AnyObject {
    func didTapClose()
    func didTapCreate()
    func didTapAddQuestion()
    func titleUpdated(title: String)
    func subtitleUpdate(subtitle: String)
    func categoryUpdate(category: String)
    func questionUpdated(at index: Int, question: String)
    func answerUpdated(at index: Int, answer: String)
    func viewDidLoad()
}

final class QuestionCreateViewController: BaseViewController, QuestionCreatePresentable, QuestionCreateViewControllable {
    
    weak var listener: QuestionCreatePresentableListener?
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let createButton = ActionButton()
    
    private let titleContentView = QuestionCreateContentView()
    private let subtitleContentView = QuestionCreateContentView()
    private let categoryContentView = QuestionCreateContentView()
    private let separator = UIView()
    private let questionAddButton = ActionButton()
    
    func appendQuestion(index: Int, title: String) {
        guard let subviewIndex = stackView.arrangedSubviews.firstIndex(of: questionAddButton) else { return }
        let questionView = QuestionCreateQuestionContentView()
        questionView.updateTitle(title)
        stackView.insertArrangedSubview(questionView, at: subviewIndex)
        bindQuestion(questionView: questionView, index: index, subviewIndex: subviewIndex)
    }
    
    func updateEnabled(isEnabled: Bool) {
        createButton.isEnabled = isEnabled
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listener?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        titleContentView.becomeFirstResponder()
    }
    
    override func setupLayout() {
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        view.addSubview(createButton)
        createButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(createButton.snp.top)
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        stackView.addArrangedSubview(titleContentView)
        stackView.addArrangedSubview(subtitleContentView)
        stackView.addArrangedSubview(categoryContentView)
        
        stackView.addArrangedSubview(separator)
        separator.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        
        stackView.addArrangedSubview(questionAddButton)
        questionAddButton.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
    
    override func setupAttributes() {
        view.backgroundColor = .csBlue1
        
        navigationView.updateTitle("Q&A 추가")
        navigationView.setup(model: .init(leftButtonType: .back, rightButtonType: .none))
        
        createButton.style = .normal
        createButton.setTitle("다음", for: .normal)
        createButton.layer.cornerRadius = 16
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInset = .init(top: 20, left: 0, bottom: 50, right: 0)
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        
        titleContentView.setup(model: .init(title: "제목", placeholder: "제목을 입력하세요"))
        subtitleContentView.setup(model: .init(title: "부제목", placeholder: "부제목을 입력하세요"))
        categoryContentView.setup(model: .init(title: "카테고리", placeholder: "카테고리를 입력하세요"))
        
        separator.backgroundColor = .csGray2
        
        questionAddButton.style = .smallSecondary
        questionAddButton.setTitle("질문 추가하기", for: .normal)
        questionAddButton.layer.cornerRadius = 16
    }
    
    override func bind() {
        navigationView.rx.leftButtonDidTap
            .bind(to: closeBinder)
            .disposed(by: disposeBag)
        
        createButton.rx.tap
            .bind(to: createBinder)
            .disposed(by: disposeBag)
        
        titleContentView.rx.text
            .compactMap { $0 }
            .bind(to: titleBinder)
            .disposed(by: disposeBag)
        
        titleContentView.rx.returnKeyDidTap
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(with: self, onNext: { this, _ in this.subtitleContentView.becomeFirstResponder() })
            .disposed(by: disposeBag)
        
        subtitleContentView.rx.text
            .compactMap { $0 }
            .bind(to: subtitleBinder)
            .disposed(by: disposeBag)
        
        subtitleContentView.rx.returnKeyDidTap
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(with: self, onNext: { this, _ in this.categoryContentView.becomeFirstResponder() })
            .disposed(by: disposeBag)
        
        categoryContentView.rx.text
            .compactMap { $0 }
            .bind(to: categoryBinder)
            .disposed(by: disposeBag)
        
        categoryContentView.rx.returnKeyDidTap
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                with: self,
                onNext: { this, _ in
                    guard let index = this.stackView.arrangedSubviews.firstIndex(of: this.separator),
                          let nextView = this.stackView.arrangedSubviews[safe: index + 1]
                    else {
                        return
                    }
                    nextView.becomeFirstResponder()
                }
            )
            .disposed(by: disposeBag)
        
        questionAddButton.rx.tap
            .bind(to: questionAddBinder)
            .disposed(by: disposeBag)
    }
    
    private func bindQuestion(questionView: QuestionCreateQuestionContentView, index: Int, subviewIndex: Int) {
        questionView.rx.question
            .compactMap { $0 }
            .subscribe(
                with: self,
                onNext: { this, question in
                    this.listener?.questionUpdated(at: index, question: question)
                }
            )
            .disposed(by: disposeBag)
        
        questionView.rx.answer
            .compactMap { $0 }
            .subscribe(
                with: self,
                onNext: { this, answer in
                    this.listener?.answerUpdated(at: index, answer: answer)
                }
            )
            .disposed(by: disposeBag)
        
        questionView.rx.returnKeyDidTap
            .map { _ in subviewIndex + 1 }
            .bind(to: questionReturnBinder)
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
    
    private var titleBinder: Binder<String> {
        return Binder(self) { this, title in
            this.listener?.titleUpdated(title: title)
        }
    }
    
    private var subtitleBinder: Binder<String> {
        return Binder(self) { this, subtitle in
            this.listener?.subtitleUpdate(subtitle: subtitle)
        }
    }
    
    private var categoryBinder: Binder<String> {
        return Binder(self) { this, category in
            this.listener?.categoryUpdate(category: category)
        }
    }
    
    private var questionAddBinder: Binder<Void> {
        return Binder(self) { this, _ in
            this.listener?.didTapAddQuestion()
        }
    }
    
    private var questionReturnBinder: Binder<Int> {
        return Binder(self) { this, index in
            guard let nextView = this.stackView.arrangedSubviews[safe: index] else { return }
            nextView.becomeFirstResponder()
        }
    }
    
}
