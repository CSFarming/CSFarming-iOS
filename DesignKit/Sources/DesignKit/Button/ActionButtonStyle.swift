//
//  ActionButtonStyle.swift
//
//
//  Created by 홍성준 on 11/26/23.
//

import UIKit

public enum ActionButtonStyle {
    
    case normal
    case smallNormal
    case secondary
    case alert
    
    var textColor: UIColor {
        switch self {
        case .normal, .smallNormal: return .csWhite
        case .secondary: return .csBlack
        case .alert: return .csWhite
        }
    }
    
    var disabledTextColor: UIColor {
        return .csWhite
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .normal, .smallNormal: return .csBlue5
        case .secondary: return .csBlue3
        case .alert: return .red
        }
    }
    
    var disabledBackgroundColor: UIColor {
        return .csGray3
    }
    
    var pressedBackgroundColor: UIColor {
        return .csWhite.withAlphaComponent(0.3)
    }
    
    var borderWidh: CGFloat {
        switch self {
        case .secondary: return 1
        default: return 0
        }
    }
    
    var borderColor: UIColor {
        switch self {
        case .secondary: return .csBlue4
        default: return .clear
        }
    }
    
    var font: UIFont {
        switch self {
        case .smallNormal:
            return .captionSB
        default:
            return .bodySB
            
        }
    }
    
    var disabledFont: UIFont {
        switch self {
        case .smallNormal:
            return .captionSB
        default:
            return .bodySB
            
        }
    }
    
}
