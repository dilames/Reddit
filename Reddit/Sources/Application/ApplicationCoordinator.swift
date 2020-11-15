//
//  ApplicationCoordinator.swift
//  Reddit
//
//  Created by Andrew Chersky on 13.11.2020.
//

import UIKit
import Platform
import Domain

final class ApplicationCoordinator {
    
    private unowned var sceneDelegate: SceneDelegate
    private unowned var appDelegate: AppDelegate
    private var useCaseProvider: UseCaseProvider
    
    init(sceneDelegate: SceneDelegate, appDelegate: AppDelegate) {
        self.sceneDelegate = sceneDelegate
        self.appDelegate = appDelegate
        self.useCaseProvider = appDelegate.platform
    }
    
    func start() {
        sceneDelegate.window?.rootViewController = feedViewController
        sceneDelegate.window?.makeKeyAndVisible()
    }
    
}

// MARK: ViewControllers
extension ApplicationCoordinator {
    
    var feedViewController: FeedViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "FeedViewController") as FeedViewController
        let viewModel = FeedViewModel(useCases: useCaseProvider)
        viewController.viewModel = viewModel
        return viewController
    }
}
