//
//  AnimatableCollectionViewCell.swift
//  Reddit
//
//  Created by Andrew Chersky on 11.11.2020.
//

import UIKit

class AnimatableCollectionViewCell: UICollectionViewCell {
    
    private var scale: CGFloat = 0.90
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        push(inside: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        push(inside: false)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        push(inside: false)
    }
    
    private func push(inside: Bool) {
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.2,
            options: [.beginFromCurrentState, .allowUserInteraction],
            animations: { self.transform = inside ? CGAffineTransform(scaleX: self.scale, y: self.scale) : .identity },
            completion: nil
        )
    }
    
}
