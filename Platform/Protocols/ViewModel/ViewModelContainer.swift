//
//  ViewModelContainer.swift
//  Reddit
//
//  Created by Andrew Chersky on 10.11.2020.
//

import Combine
import Foundation
import UIKit

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
        set { associate(value: subscriptions, forKey: &ViewModelContainerKeys.subscriptions) }
        get { return associated(valueForKey: &ViewModelContainerKeys.subscriptions)! }
    }
}

private extension ViewModelContainer where Self: NSObject {
    
    func set(viewModel: ViewModel) {
        dissociate(forKey: &ViewModelContainerKeys.viewModel)
        dissociate(forKey: &ViewModelContainerKeys.subscriptions)
        subscriptions = Set<AnyCancellable>()
        associate(value: viewModel, forKey: &ViewModelContainerKeys.viewModel)
        if let viewController = self as? UIViewController {
            viewController.publisher(for: \.isViewLoaded)
                .receive(on: OperationQueue.main)
                .filter { $0 }
                .map { _ in }
                .sink { [unowned self] _ in didSetViewModel(viewModel) }
                .store(in: &subscriptions)
        }
    }
    
}
