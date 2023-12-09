//
//  ProblemViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import UIKit
import DesignKit
import BasePresentation
import RIBs
import RxSwift

protocol ProblemPresentableListener: AnyObject {
    func didTap(directory: String)
}

final class ProblemViewController: BaseViewController, ProblemPresentable, ProblemViewControllable {
    
    weak var listener: ProblemPresentableListener?
    
    private let titleLabel = UILabel()
    private let stackView = UIStackView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupTabBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTabBar()
    }
    
    override func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    override func setupAttributes() {
        view.backgroundColor = .csBlue1
        
        titleLabel.text = "카테고리"
        titleLabel.font = .headerSB
        titleLabel.textColor = .csBlack
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 15
    }
    
    func updateModels(_ models: [ProblemContentViewModel]) {
        stackView.subviews.forEach { $0.removeFromSuperview() }
        models.forEach { model in
            let contentView = ProblemContentView()
            contentView.setup(model: model)
            contentView.rx.tap
                .bind(to: contentTapBinder)
                .disposed(by: disposeBag)
            stackView.addArrangedSubview(contentView)
        }
    }
    
    private func setupTabBar() {
        tabBarItem = UITabBarItem(
            title: "문제",
            image: UIImage(systemName: "pencil"),
            selectedImage: UIImage(systemName: "pencil")
        )
    }
    
    private var contentTapBinder: Binder<ProblemContentViewModel> {
        return Binder(self) { this, value in
            this.listener?.didTap(directory: value.directory)
        }
    }
    
}
