//
//  ViewController+Rx.swift
//  
//
//  Created by 홍성준 on 11/26/23.
//

import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: UIViewController {
    
    var viewDidLoad: ControlEvent<Void> {
        let source = methodInvoked(#selector(Base.viewDidLoad)).map { _ in }
        return .init(events: source)
    }
    
    var viewWillAppear: ControlEvent<Void> {
        let source = methodInvoked(#selector(Base.viewWillAppear)).map { _ in }
        return .init(events: source)
    }
    
}
