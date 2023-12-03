//
//  ArchiveService.swift
//
//
//  Created by 홍성준 on 12/3/23.
//

import Foundation
import Moya
import RxSwift
import BaseService

public protocol ArchiveServiceInterface: AnyObject {
    
    func requestElements() -> Single<[ContentElement]>
    func requestElements(path: String) -> Single<[ContentElement]>
    func requestElementsWithPrefix(path: String) -> Single<[ContentElement]>
    
}

public final class ArchiveService: ArchiveServiceInterface {
    
    private let provider: MoyaProvider<ArchiveAPI>
    private let parser: ArchiveParserInterface
    
    public init(
        provider: MoyaProvider<ArchiveAPI> = .init(),
        parser: ArchiveParserInterface
    ) {
        self.provider = provider
        self.parser = parser
    }
    
    public func requestElements() -> Single<[ContentElement]> {
        return provider.request(.list)
            .map(parser.parse)
    }
    
    public func requestElements(path: String) -> Single<[ContentElement]> {
        let request: Single<ArchiveListResponse> = provider.request(.detail(path: path))
        return request.map { $0.toElements() }
    }
    
    public func requestElementsWithPrefix(path: String) -> Single<[ContentElement]> {
        let request: Single<ArchiveListResponse> = provider.request(.detailWithPrefix(path: path))
        return request.map { $0.toElements() }
    }
    
}
