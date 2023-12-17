//
//  BaseTextField.swift
//
//
//  Created by 홍성준 on 12/17/23.
//

import UIKit

open class BaseTextField: UITextField {
    
    public var inset: UIEdgeInsets = .zero
    
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds).inset(by: inset)
    }
    
    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        super.placeholderRect(forBounds: bounds).inset(by: inset)
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.editingRect(forBounds: bounds).inset(by: inset)
    }
    
}
