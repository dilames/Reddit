//
//  FeedCollectionViewFlowLayout.swift
//  Reddit
//
//  Created by Andrew Chersky on 12.11.2020.
//

import UIKit

final class FeedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    var columnsCount: Int = 1
    var itemsPerPage: CGFloat = 1.5
    
    var verticalItemSpacing: CGFloat = 20
    var horizontalItemSpacing: CGFloat = 20
    
    var headerHeight: CGFloat = 0.0
    
    var itemInsets = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        minimumLineSpacing = verticalItemSpacing
        minimumInteritemSpacing = horizontalItemSpacing
        headerReferenceSize = CGSize(width: collectionView.bounds.width, height: headerHeight)
        sectionInset = itemInsets
        
        let minWidth = min(collectionView.frame.height, collectionView.frame.width)
        let estimatedItemWidth = (minWidth - verticalItemSpacing * CGFloat(columnsCount - 1)
            - sectionInset.left - sectionInset.right) / CGFloat(columnsCount)
        let collectionContentHeight = collectionView.bounds.height
            - collectionView.safeAreaInsets.top - collectionView.safeAreaInsets.bottom
            - sectionInset.top - sectionInset.bottom
        let itemHeight = collectionContentHeight / itemsPerPage
        
        var itemSize: CGSize = .zero
        itemSize.width = estimatedItemWidth
        itemSize.height = itemHeight
        
        self.itemSize = itemSize
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else { return false }
        return newBounds.size != collectionView.bounds.size
    }
    
}
