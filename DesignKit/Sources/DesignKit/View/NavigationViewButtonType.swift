//
//  NavigationViewButtonType.swift
//
//
//  Created by 홍성준 on 11/26/23.
//

import UIKit

public enum NavigationViewButtonType {
    case back
    case close
    case home
    case setting
    case none
}

extension NavigationViewButtonType {
    
    var image: UIImage? {
        let config = UIImage.SymbolConfiguration(font: .bodySB)
        switch self {
        case .back:
            return UIImage(systemName: "chevron.backward", withConfiguration: config)
        case .close:
            return UIImage(systemName: "xmark", withConfiguration: config)
        case .home:
            return UIImage(systemName: "house", withConfiguration: config)
        case .setting:
            return UIImage(systemName: "gearshape", withConfiguration: config)
        case .none:
            return nil
        }
    }
    
}
