//
//  ProblemInterface.swift
//
//
//  Created by 홍성준 on 11/26/23.
//

import RIBs

public protocol ProblemBuildable: Buildable {
    func build(withListener listener: ProblemListener) -> ViewableRouting
}

public protocol ProblemListener: AnyObject {}
