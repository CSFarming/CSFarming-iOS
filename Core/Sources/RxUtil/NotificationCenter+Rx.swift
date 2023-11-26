//
//  NotificationCenter+Rx.swift
//
//
//  Created by 홍성준 on 11/26/23.
//

import UIKit
import RxSwift
import RxCocoa

extension Notification {
    
    var keyboardSize: CGRect? {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
    }
    
}

public extension Reactive where Base: NotificationCenter {
    
    var keyboardWillShow: Observable<CGRect> {
        return base.rx.notification(UIResponder.keyboardWillShowNotification)
            .compactMap(\.keyboardSize)
    }
    
    var keyboardWillHide: Observable<Void> {
        return base.rx.notification(UIResponder.keyboardWillHideNotification)
            .map { _ in }
    }
    
}
