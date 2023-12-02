//
//  HomeService.swift
//
//
//  Created by 홍성준 on 12/2/23.
//

import Foundation
import Moya
import RxSwift
import BaseService

public protocol HomeServiceInterface: AnyObject {
    func requestElements() -> Single<[HomeElement]>
    func requestElements(path: String) -> Single<[HomeElement]>
}

public final class HomeService: HomeServiceInterface {
    
    private let provider: MoyaProvider<HomeAPI>
    private let parser: HomeParserInterface
    
    public init(
        provider: MoyaProvider<HomeAPI> = .init(),
        parser: HomeParserInterface
    ) {
        self.provider = provider
        self.parser = parser
    }
    
    public func requestElements() -> Single<[HomeElement]> {
        return provider.request(.list)
            .map(parser.parse)
    }
    
    public func requestElements(path: String) -> Single<[HomeElement]> {
        let request: Single<HomeListResponse> = provider.request(.detail(path: path))
        return request.map { $0.toElements() }
    }
    
}
