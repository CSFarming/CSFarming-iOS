//
//  BaseViewController.swift
//
//
//  Created by 홍성준 on 11/26/23.
//

import UIKit
import RxSwift

open class BaseViewController: UIViewController {
    
    public var disposeBag = DisposeBag()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupAttributes()
        bind()
    }
    
    open func setupLayout() {}
    
    open func setupAttributes() {}
    
    open func bind() {}
    
}
