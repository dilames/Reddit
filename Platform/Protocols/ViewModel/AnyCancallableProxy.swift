//
//  AnyCancallableProxy.swift
//  Platform
//
//  Created by Andrew Chersky on 16.11.2020.
//

import Foundation
import Combine

@objc internal class AnyCancallablesProxy: NSObject {
    
    private(set) var cancallables = NSMutableArray()
    
    init(_ cancallables: [Cancellable]) {
        self.cancallables.addObjects(from: cancallables)
    }
    
}
