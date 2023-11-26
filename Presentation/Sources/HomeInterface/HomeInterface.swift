//
//  HomeInterface.swift
//
//
//  Created by 홍성준 on 11/26/23.
//

import RIBs

public protocol HomeBuildable: Buildable {
    func build(withListener listener: HomeListener) -> ViewableRouting
}

public protocol HomeListener: AnyObject {}
