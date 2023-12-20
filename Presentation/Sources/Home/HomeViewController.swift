//
//  HomeViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import UIKit
import RIBs
import CoreUtil
import RxSwift
import SnapKit
import DesignKit
import BasePresentation

protocol HomePresentableListener: AnyObject {}

final class HomeViewController: BaseViewController, HomePresentable, HomeViewControllable {
    
    weak var listener: HomePresentableListener?
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupTabBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTabBar()
    }
    
    func setDashboard(_ viewControllable: ViewControllable) {
        let viewController = viewControllable.uiviewController
        addChild(viewController)
        stackView.addArrangedSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    
    func removeDashboard(_ viewControllable: ViewControllable) {
        let viewController = viewControllable.uiviewController
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    override func setupLayout() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        view.backgroundColor = .csBlue1
        
        scrollView.contentInset = .init(top: 40, left: 0, bottom: 40, right: 0)
        scrollView.showsVerticalScrollIndicator = false
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 60
    }
    
    private func setupTabBar() {
        tabBarItem = UITabBarItem(
            title: "홈", 
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
    }
    
}

