//
//  AnimateBaseView.swift
//
//
//  Created by 홍성준 on 12/20/23.
//

import UIKit

open class AnimateBaseView: BaseView {
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        selectAnimate()
    }
    
}
