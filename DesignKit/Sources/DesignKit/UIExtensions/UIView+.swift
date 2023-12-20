//
//  UIView+.swift
//
//
//  Created by 홍성준 on 11/26/23.
//

import UIKit

public extension UIView {
    
    func maskCornerRadius(cornerRadius: CGFloat, cornerMask: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: cornerMask)
    }
    
    func selectAnimate(
        scaleX x: CGFloat = 1.05,
        scaleY y: CGFloat = 1.05,
        withDuration duration: CGFloat = 0.3,
        delay: CGFloat = 0.0,
        options: AnimationOptions = .curveEaseInOut
    ) {
        self.transform = CGAffineTransform(scaleX: x, y: y)
        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: options
        ) {
            self.transform = .identity
        }
    }
    
    func shakeAnimate(
        translationX x: CGFloat = 20,
        translationY y: CGFloat = 0,
        withDuration duration: CGFloat = 0.3,
        delay: CGFloat = 0.0,
        usingSpringWithDamping: CGFloat = 0.2,
        initialSpringVelocity springVelocity: CGFloat = 1
    ) {
        self.transform = CGAffineTransform(translationX: x, y: y)
        UIView.animate(
            withDuration: duration,
            delay: delay,
            usingSpringWithDamping: usingSpringWithDamping,
            initialSpringVelocity: springVelocity
        ) {
            self.transform = .identity
        }
    }
    
}
