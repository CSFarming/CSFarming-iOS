//
//  NavigationButton.swift
//
//
//  Created by 홍성준 on 11/26/23.
//

import UIKit

public final class NavigationViewButton: UIButton {
    
    public var type: NavigationViewButtonType = .none {
        didSet { setupType() }
    }
    
    public override var isHighlighted: Bool {
        didSet { tintColor = isHighlighted ? .csGray3 : .csBlack }
    }
    
}

private extension NavigationViewButton {
    
    func setupType() {
        setImage(type.image?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
}
