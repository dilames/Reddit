//
//  Publisher+Bind.swift
//  Reddit
//
//  Created by Andrew Chersky on 13.11.2020.
//

import Foundation
import Combine

public typealias Binding = Subscriber

public extension Publisher where Failure == Never {
    
    func bind<B: Binding>(subscriber: B) -> AnyCancellable where B.Failure == Never, B.Input == Output {
        return handleEvents(receiveSubscription: { subscriber.receive(subscription: $0) })
            .sink { _ = subscriber.receive($0) }
    }
    
}
