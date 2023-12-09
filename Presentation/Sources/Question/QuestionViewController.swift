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

protocol QuestionPresentableListener: AnyObject {
    func didTapClose()
}

final class QuestionViewController: BaseViewController, QuestionPresentable, QuestionViewControllable {
    
    weak var listener: QuestionPresentableListener?
    
    override func setupLayout() {
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    override func setupAttributes() {
        view.backgroundColor = .csBlue1
        
        navigationView.setup(model: .init(
            leftButtonType: .back,
            rightButtonType: .none
        ))
    }
    
    override func bind() {
        navigationView.rx.leftButtonDidTap
            .bind(to: closeBinder)
            .disposed(by: disposeBag)
    }
    
    private var closeBinder: Binder<Void> {
        return Binder(self) { this, _ in
            this.listener?.didTapClose()
        }
    }
    
}
