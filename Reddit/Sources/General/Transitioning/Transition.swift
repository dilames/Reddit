//
//  Transition.swift
//  Reddit
//
//  Created by Andrew Chersky on 11.11.2020.
//

import protocol UIKit.UIViewControllerTransitioningDelegate
import protocol UIKit.UIViewControllerAnimatedTransitioning

import class UIKit.UIViewController
import class UIKit.NSObject

import class UIKit.UICollectionViewCell

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
    
}
