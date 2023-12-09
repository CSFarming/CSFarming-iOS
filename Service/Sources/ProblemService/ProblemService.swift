//
//  ProblemService.swift
//
//
//  Created by 홍성준 on 12/9/23.
//

import Foundation
import Moya
import RxSwift
import BaseService

public protocol ProblemServiceInterface: AnyObject {
    func requestElements() -> Single<[ContentElement]>
}

public final class ProblemService: ProblemServiceInterface {
    
    private let provider: MoyaProvider<ProblemAPI>
    private let parser: GitHubRootParserInterface
    
    public init(
        provider: MoyaProvider<ProblemAPI> = .init(),
        parser: GitHubRootParserInterface
    ) {
        self.provider = provider
        self.parser = parser
    }
    
    public func requestElements() -> Single<[ContentElement]> {
        return provider.request(.list)
            .map(parser.parse)
    }
    
}
