//
//  Transition.swift
//  Reddit
//
//  Created by Andrew Chersky on 11.11.2020.
//

import UIKit

final class Transition: NSObject, UIViewControllerTransitioningDelegate {
    
    private let cell: UICollectionViewCell
    
    init(cell: UICollectionViewCell) {
        self.cell = cell
        super.init()
    }
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AppearingTransitioning(viewCell: cell)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DisappearingTransitioning(viewCell: cell)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return TransitionController(presentedViewController: presented, presenting: presenting)
    }
    
}
