//
//  Cancallable.swift
//  Reddit
//
//  Created by Andrew Chersky on 10.11.2020.
//

import Foundation

public protocol Cancellable {
    var isCancelled: Bool { get }
    func cancel()
}

public final class CancellableToken: Cancellable {
    
    let cancelAction: () -> Void

    public fileprivate(set) var isCancelled = false

    fileprivate var lock: DispatchSemaphore = DispatchSemaphore(value: 1)

    public func cancel() {
        _ = lock.wait(timeout: DispatchTime.distantFuture)
        defer { lock.signal() }
        guard !isCancelled else { return }
        isCancelled = true
        cancelAction()
    }

    public init(action: @escaping () -> Void) {
        self.cancelAction = action
    }

}
