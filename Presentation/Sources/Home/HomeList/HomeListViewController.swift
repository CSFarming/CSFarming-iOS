//
//  HomeListViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/2/23.
//

import UIKit
import RIBs
import RxSwift
import RxCocoa
import SnapKit
import BasePresentation

protocol HomeListPresentableListener: AnyObject {
    func didTapClose()
}

final class HomeListViewController: BaseViewController, HomeListPresentable, HomeListViewControllable {
    
    weak var listener: HomeListPresentableListener?
    
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
