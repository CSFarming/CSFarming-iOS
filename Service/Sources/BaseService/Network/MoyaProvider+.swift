//
//  MoyaProvider+.swift
//
//
//  Created by 홍성준 on 12/2/23.
//

import Foundation
import Moya
import RxSwift

public extension MoyaProvider {
    
    func request<Response: Decodable>(
        _ target: Target,
        callbackQueue: DispatchQueue? = .none,
        progress: ProgressBlock? = .none
    ) -> Single<Response> {
        return Single<Response>.create { single -> Disposable in
            let request = self.request(target, callbackQueue: callbackQueue, progress: progress) { result in
                switch result {
                case .success(let moyaResponse):
                    do {
                        let response = try moyaResponse.map(Response.self)
                        single(.success(response))
                    } catch {
                        single(.failure(error))
                    }
                    
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func request(
        _ target: Target,
        callbackQueue: DispatchQueue? = .none,
        progress: ProgressBlock? = .none
    ) -> Single<String> {
        return Single<String>.create { single -> Disposable in
            let request = self.request(target, callbackQueue: callbackQueue, progress: progress) { result in
                switch result {
                case .success(let moyaResponse):
                    do {
                        let response = try moyaResponse.mapString()
                        single(.success(response))
                    } catch {
                        single(.failure(error))
                    }
                    
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
}
