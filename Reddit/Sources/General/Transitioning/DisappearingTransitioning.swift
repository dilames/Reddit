//
//  DisappearingTransitioning.swift
//  Reddit
//
//  Created by Andrew Chersky on 11.11.2020.
//

import UIKit

final class DisappearingTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let viewCell: UICollectionViewCell
    private let animationDuration: TimeInterval = 0.60
    
    private var currentAnimator: UIViewImplicitlyAnimating?
    
    init(viewCell: UICollectionViewCell) {
        self.viewCell = viewCell
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        currentAnimator = UIViewPropertyAnimator()
        
        guard
            let fromViewController = transitionContext.viewController(forKey: .from),
            let presentation = viewCell.layer.presentation(),
            let contentOffset = (viewCell.superview as? UICollectionView)?.contentOffset,
            let toFrame = viewCell.superview?.convert(presentation.frame, to: nil)
            else { return }
        
        let containerView = transitionContext.containerView
        containerView.clipsToBounds = true
        containerView.layer.masksToBounds = true
        
        currentAnimator?.addAnimations? {
            let dx = toFrame.width / fromViewController.view.frame.width
            let dy = toFrame.height / fromViewController.view.frame.height
            containerView.center = self.viewCell.center.applying(.init(translationX: -contentOffset.x, y: -contentOffset.y))
            containerView.transform = .init(scaleX: dx, y: dy)
            containerView.layer.cornerRadius = self.viewCell.layer.cornerRadius * fromViewController.view.frame.width / toFrame.width
        }
        
        currentAnimator?.addCompletion? { _ in
            containerView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
        
        currentAnimator?.startAnimation()
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        currentAnimator = nil
    }
    
}
