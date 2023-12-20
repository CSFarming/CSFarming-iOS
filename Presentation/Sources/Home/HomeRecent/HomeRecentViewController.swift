//
//  HomeRecentViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/20/23.
//

import RIBs
import RxSwift
import UIKit
import DesignKit
import BasePresentation

protocol HomeRecentPresentableListener: AnyObject {
    func didSelect(at index: Int)
    func viewWillAppear()
}

final class HomeRecentViewController: BaseViewController, HomeRecentPresentable, HomeRecentViewControllable {
    
    weak var listener: HomeRecentPresentableListener?
    
    private let titleLabel = UILabel()
    private let stackView = UIStackView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listener?.viewWillAppear()
    }
    
    func setup(items: [HomeRecentItem]) {
        stackView.subviews.forEach { $0.removeFromSuperview() }
        
        items.enumerated().forEach { offset, item in
            switch item {
            case .post(let model):
                let contentView = HomeRecentPostView()
                contentView.setup(model: model)
                stackView.addArrangedSubview(contentView)
                contentView.rx.tapGesture
                    .map { _ in offset }
                    .bind(to: tapBinder)
                    .disposed(by: disposeBag)
                
            case .problem(let model):
                let contentView = HomeRecentProblemView()
                contentView.setup(model: model)
                stackView.addArrangedSubview(contentView)
                contentView.rx.tapGesture
                    .map { _ in offset }
                    .bind(to: tapBinder)
                    .disposed(by: disposeBag)
            }
        }
    }
    
    override func setupLayout() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        view.backgroundColor = .csBlue1
        
        titleLabel.text = "최근 내역"
        titleLabel.font = .headerSB
        titleLabel.textColor = .csBlack
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
    }
    
    private var tapBinder: Binder<Int> {
        return Binder(self) { this, index in
            this.listener?.didSelect(at: index)
        }
    }
    
}
