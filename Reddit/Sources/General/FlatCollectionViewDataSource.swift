//
//  FlatCollectionViewDataSource.swift
//  Reddit
//
//  Created by Andrew Chersky on 13.11.2020.
//

import Combine
import UIKit

final class FlatCollectionViewDataSource<Collection>: NSObject, UICollectionViewDataSource
where
    Collection: RandomAccessCollection,
    Collection.Index == Int,
    Collection.Element: Hashable {
    
    typealias CellConstuctor = (UICollectionView, Collection?, IndexPath) -> UICollectionViewCell
    
    private var collection: Collection?
    private let cellConstructor: CellConstuctor
    
    private weak var forwardingDataSource: UICollectionViewDataSource?
    
    init(cellConstructor: @escaping CellConstuctor, forwardingDataSource: UICollectionViewDataSource? = nil) {
        self.cellConstructor = cellConstructor
        self.forwardingDataSource = forwardingDataSource
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return cellConstructor(collectionView, collection, indexPath)
    }
    
    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        return forwardingDataSource
    }
    
    public func subscriber(for collectionView: UICollectionView) -> AnySubscriber<Collection, Never> {
        return AnySubscriber<Collection, Never>(
            receiveSubscription: { $0.request(.unlimited) },
            receiveValue: { [weak self] in
                guard let self = self else { return .none }
                self.collection = $0
                collectionView.reloadData()
                return .unlimited
            }
        )
    }
    
}
