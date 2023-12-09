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
    func requestElements() -> Single<[ProblemElement]>
    func requestElements(directory: String) -> Single<[ProblemElement]>
}

public final class ProblemService: ProblemServiceInterface {
    
    private let provider: MoyaProvider<ProblemAPI>
    
    public init(provider: MoyaProvider<ProblemAPI> = .init()) {
        self.provider = provider
    }
    
    public func requestElements() -> Single<[ProblemElement]> {
        let request: Single<ProblemListResponse> = provider.request(.list)
        return request.map { $0.toElements() }
    }
    
    public func requestElements(directory: String) -> Single<[ProblemElement]> {
        let request: Single<ProblemListResponse> = provider.request(.problem(directory))
        return request.map { $0.toElements() }
    }
    
}
