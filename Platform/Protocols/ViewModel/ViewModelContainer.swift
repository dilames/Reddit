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
    static var cancallableBag = "cancallableBag"
}

// MARK: - ViewModelContainer
public protocol ViewModelContainer: NSObject {
    associatedtype ViewModel
    var viewModel: ViewModel { get set }
    func didSetViewModel(_ viewModel: ViewModel)
}

public extension ViewModelContainer where Self: UIViewController {
    var viewModel: ViewModel {
        get { return associated(valueForKey: &ViewModelContainerKeys.viewModel)! }
        set { set(viewModel: newValue) }
    }
}

private extension ViewModelContainer where Self: NSObject {
    
    func set(viewModel model: ViewModel) {
        var cancallableBag = Set<AnyCancellable>()
        associate(value: cancallableBag, forKey: &ViewModelContainerKeys.cancallableBag)
        associate(value: model, forKey: &ViewModelContainerKeys.viewModel)
        if let viewController = self as? UIViewController {
            viewController.publisher(for: \.isViewLoaded)
                .receive(on: OperationQueue.main)
                .filter { $0 }
                .map { _ in }
                .sink { [unowned self] _ in didSetViewModel(viewModel) }
                .store(in: &cancallableBag)
        }
    }
    
}
