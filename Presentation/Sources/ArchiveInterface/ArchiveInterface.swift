//
//  ArchiveInterface.swift
//
//
//  Created by 홍성준 on 12/3/23.
//

import Foundation
import RIBs

public protocol ArchiveBuildable: Buildable {
    func build(withListener listener: ArchiveListener) -> ViewableRouting
}

public protocol ArchiveListener: AnyObject {}
