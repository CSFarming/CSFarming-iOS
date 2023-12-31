//
//  QuestionInterface.swift
//
//
//  Created by 홍성준 on 12/9/23.
//

import RIBs

public protocol QuestionBuildable: Buildable {
    func build(withListener listener: QuestionListener, title: String, directory: String) -> ViewableRouting
}

public protocol QuestionListener: AnyObject {
    func questionDidTapClose()
}
