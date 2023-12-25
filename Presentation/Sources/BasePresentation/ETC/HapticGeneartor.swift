//
//  HapticGeneartor.swift
//
//
//  Created by 홍성준 on 12/25/23.
//

import UIKit

public protocol HapticGeneartorInterface {
    func impact()
    func impact(intensity: CGFloat)
    func impact(style: HapticStyle)
}

public enum HapticStyle: CGFloat {
    case light = 0.3
    case medium = 0.6
    case heavy = 1.0
}

final class HapticGeneartor: HapticGeneartorInterface {
    
    static let shared = HapticGeneartor()
    
    private init() {}
    
    private let generator = UIImpactFeedbackGenerator()
    
    func impact() {
        generator.prepare()
        generator.impactOccurred()
    }
    
    func impact(intensity: CGFloat) {
        generator.prepare()
        generator.impactOccurred(intensity: intensity)
    }
    
    func impact(style: HapticStyle) {
        generator.prepare()
        generator.impactOccurred(intensity: style.rawValue)
    }
    
}
