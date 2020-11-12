//
//  ReusableViewModelContainer.swift
//  Reddit
//
//  Created by Andrew Chersky on 10.11.2020.
//

import Combine
import Foundation

private enum ViewModelContainerKeys {
    static var viewModel = "viewModel"
    static var cancallableBag = "cancallableBag"
}

public protocol ReusableViewModelContainer {
    associatedtype ViewModel
    var viewModel: ViewModel? { get set }
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
    
}

private extension ReusableViewModelContainer where Self: NSObject {
    
    func set(viewModel: ViewModel?) {
        dissociate(forKey: &ViewModelContainerKeys.cancallableBag)
        dissociate(forKey: &ViewModelContainerKeys.viewModel)
        guard let viewModel = viewModel else { return }
        associate(value: viewModel, forKey: &ViewModelContainerKeys.viewModel)
    }
}
