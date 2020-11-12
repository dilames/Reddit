//
//  ViewModelInterface.swift
//  Reddit
//
//  Created by Andrew Chersky on 10.11.2020.
//

public protocol ViewModel {
    associatedtype Input = Void
    associatedtype Output = Void
    func transform(_ input: Input) -> Output
}

public extension ViewModel where Input == Void, Output == Void {
    func transform(_ input: Input) -> Output {}
}

public extension ViewModel where Input == Void {
    func transform() -> Output { return transform(()) }
}
