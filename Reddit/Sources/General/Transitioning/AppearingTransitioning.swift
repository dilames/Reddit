//
//  AppearingTransitioning.swift
//  Reddit
//
//  Created by Andrew Chersky on 11.11.2020.
//

import UIKit

final class AppearingTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let viewCell: UICollectionViewCell
    private let animationDuration: TimeInterval = 0.25
    
    private var currentAnimator: UIViewImplicitlyAnimating?
    
    init(viewCell: UICollectionViewCell) {
        self.viewCell = viewCell
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        currentAnimator = interruptibleAnimator(using: transitionContext)
        
        guard
            let toViewController = transitionContext.viewController(forKey: .to),
            let contentOffset = (viewCell.superview as? UICollectionView)?.contentOffset,
            let presentation = viewCell.layer.presentation(),
            let sourceFrame = viewCell.superview?.convert(presentation.frame, to: nil)
            else { return }
        
        let centerBuffer = viewCell.center
        let zPositionBuffer = viewCell.layer.zPosition
        let cornerRadiusBuffer = viewCell.layer.cornerRadius
        
        self.viewCell.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        
        currentAnimator?.addAnimations? {
            let dx = toViewController.view.frame.width / sourceFrame.width
            let dy = toViewController.view.frame.height / sourceFrame.height
            self.viewCell.center = toViewController.view.center.applying(.init(translationX: contentOffset.x, y: 0))
            self.viewCell.transform = .init(scaleX: dx, y: dy)
            self.viewCell.layer.cornerRadius = 0
        }
        
        currentAnimator?.addCompletion? { _ in
            self.viewCell.transform = .identity
            self.viewCell.center = centerBuffer
            self.viewCell.layer.zPosition = zPositionBuffer
            self.viewCell.layer.cornerRadius = cornerRadiusBuffer
            transitionContext.containerView.addSubview(toViewController.view)
            transitionContext.completeTransition(true)
        }
        
        currentAnimator?.startAnimation()
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        currentAnimator = nil
    }
    
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        
        guard
            let presentation = viewCell.layer.presentation(),
            let fromFrame = viewCell.superview?.convert(presentation.frame, to: nil)
            else { return UIViewPropertyAnimator() }
        
        let distance = abs(fromFrame.minY)
        let extent = fromFrame.minY < 0 ? fromFrame.height : UIScreen.main.bounds.height
        let dampingInterval: CGFloat = 0.3
        
        let baselineDuration: TimeInterval = 0.5
        let maximumDuration: TimeInterval = 0.9
        let duration: TimeInterval = baselineDuration + (maximumDuration - baselineDuration) * TimeInterval(max(0, distance) / UIScreen.main.bounds.height)
        
        let springTiming = UISpringTimingParameters(
            dampingRatio: 1.0 - dampingInterval * (distance / extent),
            initialVelocity: .zero
        )
        
        return UIViewPropertyAnimator(duration: duration, timingParameters: springTiming)
    }
    
}
