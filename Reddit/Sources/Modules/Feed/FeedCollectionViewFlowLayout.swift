//
//  FeedCollectionViewFlowLayout.swift
//  Reddit
//
//  Created by Andrew Chersky on 12.11.2020.
//

import UIKit

final class FeedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    var itemsPerColumn: Int = 1
    var itemsPerPage: CGFloat = 1.5
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        minimumLineSpacing = 20.0
        minimumInteritemSpacing = 20.0
        headerReferenceSize = CGSize(width: collectionView.bounds.width, height: 0.0)
        sectionInset = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
        estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else { return false }
        return newBounds.size != collectionView.bounds.size
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard
            let attributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes,
            let collectionView = collectionView
        else { return UICollectionViewLayoutAttributes() }
        let itemsPerColumn = CGFloat(self.itemsPerColumn)
        let lineSpacing = minimumLineSpacing * (itemsPerColumn - 1)
        attributes.frame.origin.x = sectionInset.left
        attributes.frame.size.width = ((collectionView.bounds.width - sectionInset.left - sectionInset.right - lineSpacing) / itemsPerColumn)
        return attributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return super.layoutAttributesForElements(in: rect)?
            .compactMap { $0.copy() as? UICollectionViewLayoutAttributes }
            .map {
                guard
                    $0.representedElementCategory == .cell,
                    let frame = layoutAttributesForItem(at: $0.indexPath)?.frame
                else { return $0 }
                $0.frame = frame
                return $0
            }
    }
    
}
