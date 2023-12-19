//
//  ViewControllerMock.swift
//
//
//  Created by 홍성준 on 12/19/23.
//

import UIKit
import RIBs

public final class ViewControllerMock: UIViewController, ViewControllable {
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public var presentCallCount = 0
    public override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentCallCount += 1
    }
    
    public var dismissCallCount = 0
    public override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dismissCallCount += 1
    }
    
}
