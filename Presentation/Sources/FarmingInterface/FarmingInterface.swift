//
//  FarmingInterface.swift
//
//
//  Created by 홍성준 on 12/21/23.
//

import RIBs

public protocol FarmingHomeBuildable: Buildable {
    func build(withListener listener: FarmingHomeListener) -> ViewableRouting
}

public protocol FarmingHomeListener: AnyObject {}
