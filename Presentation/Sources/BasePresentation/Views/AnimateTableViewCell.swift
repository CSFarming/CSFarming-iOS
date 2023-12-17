//
//  AnimateTableViewCell.swift
//
//
//  Created by 홍성준 on 12/2/23.
//

import UIKit

open class AnimateTableViewCell: BaseTableViewCell {
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        selectAnimate()
    }
    
}
