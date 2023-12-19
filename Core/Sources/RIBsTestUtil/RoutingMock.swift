//
//  RoutingMock.swift
//
//
//  Created by 홍성준 on 12/19/23.
//

import Foundation
import RIBs
import RxSwift

public final class RoutingMock: Routing {
    
    public var interactable: Interactable
    
    public var children: [Routing] = []
    
    public init(interactable: Interactable) {
        self.interactable = interactable
    }
    
    public var loadCallCount = 0
    public func load() {
        loadCallCount += 1
    }
    
    public var attachChildCallCount = 0
    public var attachChildChild: Routing?
    public func attachChild(_ child: Routing) {
        attachChildCallCount += 1
        attachChildChild = child
    }
    
    public var detachChildCallCount = 0
    public var detachChildChild: Routing?
    public func detachChild(_ child: Routing) {
        detachChildCallCount += 1
        detachChildChild = child
    }
    
    public var lifecycle: Observable<RouterLifecycle> {
        lifecycleRelay.asObservable()
    }
    public var lifecycleRelay = PublishSubject<RouterLifecycle>()
    
}
