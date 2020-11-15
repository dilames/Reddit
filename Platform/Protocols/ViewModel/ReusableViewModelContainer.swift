//
//  ReusableViewModelContainer.swift
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

public protocol ReusableViewModelContainer {
    associatedtype ViewModel
    var viewModel: ViewModel? { get set }
    var subscriptions: Set<AnyCancellable> { get set }
    func prepareForReuse()
    func didSetViewModel(_ viewModel: ViewModel)
}

public extension ReusableViewModelContainer where Self: NSObject {
    
    var viewModel: ViewModel? {
        get {
            return associated(valueForKey: &ViewModelContainerKeys.viewModel)!
        }
        set {
            set(viewModel: newValue)
            guard let viewModel = viewModel else { return }
            didSetViewModel(viewModel)
        }
    }
    
    var subscriptions: Set<AnyCancellable> {
        set {
            let proxy = AnyCancallablesProxy(Array(newValue))
            dissociate(forKey: &ViewModelContainerKeys.subscriptions)
            associate(value: proxy, forKey: &ViewModelContainerKeys.subscriptions) }
        get {
            let proxy: AnyCancallablesProxy = associated(valueForKey: &ViewModelContainerKeys.subscriptions)!
            return Set(proxy.cancallables as! Array<AnyCancellable>)
        }
    }
    
}

private extension ReusableViewModelContainer where Self: NSObject {
    
    func set(viewModel: ViewModel?) {
        subscriptions = Set<AnyCancellable>()
        dissociate(forKey: &ViewModelContainerKeys.viewModel)
        guard let viewModel = viewModel else { return } 
        associate(value: viewModel, forKey: &ViewModelContainerKeys.viewModel)
        if let viewController = self as? UIViewController {
            viewController.publisher(for: \.view, options: [.initial, .new, .old])
                .receive(on: OperationQueue.main)
                .filter { $0 != .none }
                .first()
                .map { _ in }
                .sink { [unowned self] _ in didSetViewModel(viewModel) }
                .store(in: &subscriptions)
        } else {
            Just(true)
                .receive(on: OperationQueue.main)
                .map { _ in }
                .sink { [unowned self] _ in didSetViewModel(viewModel) }
                .store(in: &subscriptions)
        }
    }
}
