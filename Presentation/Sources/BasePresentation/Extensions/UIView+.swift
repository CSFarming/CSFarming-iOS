//
//  UIView+.swift
//
//
//  Created by 홍성준 on 11/26/23.
//

import UIKit
import RxSwift
import RxCocoa

public extension UIView {
    
    @discardableResult
    func addTapGesture() -> UITapGestureRecognizer {
        let gesture = UITapGestureRecognizer()
        isUserInteractionEnabled = true
        addGestureRecognizer(gesture)
        return gesture
    }
    
}

public extension Reactive where Base: UIView {
    
    var tapGesture: ControlEvent<UITapGestureRecognizer> {
        let source = base.addTapGesture().rx.event
            .filter { $0.state == .recognized }
        return ControlEvent(events: source)
    }
    
}
