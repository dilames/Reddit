//
//  ViewModelContainer.swift
//  Reddit
//
//  Created by Andrew Chersky on 10.11.2020.
//

import Combine
import Foundation
import UIKit

@objc private class AnyCancallablesProxy: NSObject {
    
    private(set) var cancallables = NSMutableArray()
    
    init(_ cancallables: [AnyCancellable]) {
        self.cancallables.addObjects(from: cancallables)
    }
    
}


private enum ViewModelContainerKeys {
    static var viewModel = "viewModel"
    static var subscriptions = "subscriptions"
}

// MARK: - ViewModelContainer
public protocol ViewModelContainer: NSObject {
    associatedtype ViewModel
    var viewModel: ViewModel { get set }
    var subscriptions: Set<AnyCancellable> { get set }
    func didSetViewModel(_ viewModel: ViewModel)
}

public extension ViewModelContainer where Self: UIViewController {
    
    var viewModel: ViewModel {
        get { return associated(valueForKey: &ViewModelContainerKeys.viewModel)! }
        set { set(viewModel: newValue) }
    }
    
    var subscriptions: Set<AnyCancellable> {
        set {
            let proxy = AnyCancallablesProxy(Array(newValue))
            associate(value: proxy, forKey: &ViewModelContainerKeys.subscriptions) }
        get {
            let proxy: AnyCancallablesProxy = associated(valueForKey: &ViewModelContainerKeys.subscriptions)!
            return Set(proxy.cancallables as! Array<AnyCancellable>)
        }
    }
    
}

private extension ViewModelContainer where Self: NSObject {
    
    func set(viewModel: ViewModel) {
        subscriptions = Set<AnyCancellable>()
        dissociate(forKey: &ViewModelContainerKeys.viewModel)
        associate(value: viewModel, forKey: &ViewModelContainerKeys.viewModel)
        if let viewController = self as? UIViewController {
            viewController.publisher(for: \.view, options: [.initial, .new, .old])
                .receive(on: OperationQueue.main)
                .filter { $0 != .none }
                .map { _ in }
                .sink { [unowned self] _ in didSetViewModel(viewModel) }
                .store(in: &subscriptions)
        }
        
    }
    
}
