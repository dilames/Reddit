//
//  TransitioningController.swift
//  Reddit
//
//  Created by Andrew Chersky on 16.11.2020.
//

import Foundation
import UIKit

final class TransitionController: UIPresentationController {
    
    private lazy var blurView = UIVisualEffectView(effect: nil)
    
    override var shouldRemovePresentersView: Bool {
        return false
    }
    
    override func presentationTransitionWillBegin() {
        let container = containerView!
        blurView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 0),
            blurView.rightAnchor.constraint(equalTo: container.rightAnchor, constant: 0),
            blurView.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            blurView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0)
            ])
        blurView.alpha = 0.0
        
        presentingViewController.beginAppearanceTransition(false, animated: false)
        presentedViewController.transitionCoordinator!.animate(alongsideTransition: { (ctx) in
            UIView.animate(withDuration: 0.5, animations: {
                self.blurView.effect = UIBlurEffect(style: .light)
                self.blurView.alpha = 1
            })
        }) { (ctx) in }
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        presentingViewController.endAppearanceTransition()
    }
    
    override func dismissalTransitionWillBegin() {
        presentingViewController.beginAppearanceTransition(true, animated: true)
        presentedViewController.transitionCoordinator!.animate(alongsideTransition: { (ctx) in
            self.blurView.alpha = 0.0
        }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        presentingViewController.endAppearanceTransition()
        if completed {
            blurView.removeFromSuperview()
        }
    }
    
}
