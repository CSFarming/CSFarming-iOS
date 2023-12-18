//
//  QuestionCreateInterface.swift
//
//
//  Created by 홍성준 on 12/17/23.
//

import RIBs

public protocol QuestionCreateBuildable: Buildable {
    func build(withListener listener: QuestionCreateListener) -> ViewableRouting
}

public protocol QuestionCreateListener: AnyObject {
    func questionCreateDidTapClose()
    func questionCreateDidCreate()
}
