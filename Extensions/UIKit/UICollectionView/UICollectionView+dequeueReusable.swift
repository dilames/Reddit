//
//  UICollectionView+dequeueReusable.swift
//  Reddit
//
//  Created by Andrew Chersky on 11.11.2020.
//

import UIKit

extension UICollectionView {
    
    func dequeueReusableCell<T: UICollectionViewCell>(forType cellType: T.Type, for indexPath: IndexPath) -> T {
        let reusableIdentifier = String(describing: cellType)
        return dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath) as! T
    }
    
}
