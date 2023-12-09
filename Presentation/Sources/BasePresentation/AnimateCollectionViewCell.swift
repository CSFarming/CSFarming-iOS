//
//  AnimateCollectionViewCell.swift
//
//
//  Created by 홍성준 on 12/9/23.
//

import UIKit

open class AnimateCollectionViewCell: BaseCollectionViewCell {
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        selectAnimate()
    }
    
}
