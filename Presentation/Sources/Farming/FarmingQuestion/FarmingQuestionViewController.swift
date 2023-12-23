//
//  FarmingQuestionViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/23/23.
//

import RIBs
import RxSwift
import UIKit
import SnapKit
import DesignKit
import BasePresentation

protocol FarmingQuestionPresentableListener: AnyObject {
    func didTapClose()
}

final class FarmingQuestionViewController: BaseViewController, FarmingQuestionPresentable, FarmingQuestionViewControllable {
    
    weak var listener: FarmingQuestionPresentableListener?
    
    func updateTitle(_ title: String) {
        navigationView.updateTitle(title)
    }
    
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
        
        navigationView.setup(model: .init(leftButtonType: .back, rightButtonType: .none))
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
