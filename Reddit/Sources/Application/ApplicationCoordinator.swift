//
//  ApplicationCoordinator.swift
//  Reddit
//
//  Created by Andrew Chersky on 13.11.2020.
//

import UIKit
import Platform

final class ApplicationCoordinator {
    
    private unowned var sceneDelegate: SceneDelegate
    private unowned var appDelegate: AppDelegate
    
    init(sceneDelegate: SceneDelegate, appDelegate: AppDelegate) {
        self.sceneDelegate = sceneDelegate
        self.appDelegate = appDelegate
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
        let viewModel = FeedViewModel()
        viewController.viewModel = viewModel
        return viewController
    }
}
