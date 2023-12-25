//
//  BaseViewController.swift
//
//
//  Created by 홍성준 on 11/26/23.
//

import UIKit
import RxSwift
import RxCocoa
import DesignKit

open class BaseViewController: UIViewController {
    
    public let navigationView = NavigationView()
    public let hapticGenerator: HapticGeneartorInterface = HapticGeneartor.shared
    public var disposeBag = DisposeBag()
    public var isSwipeBackEnabled = true {
        didSet { updateSwipeBack() }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupAttributes()
        bind()
    }
    
    open func setupLayout() {}
    
    open func setupAttributes() {}
    
    open func bind() {}
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateSwipeBack()
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingFromParent {
            navigationView.leftButton.sendActions(for: .touchUpInside)
        }
    }
    
    private func updateSwipeBack() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = isSwipeBackEnabled
    }
    
}
