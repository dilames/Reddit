//
//  FeedViewController.swift
//  Reddit
//
//  Created by Andrew Chersky on 10.11.2020.
//

import UIKit
import Combine
import Extensions
import Platform
import Domain

final class FeedViewController: UIViewController, ViewModelContainer {
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var flatCollectionDataSource = FlatCollectionViewDataSource<[Child]>(
        cellConstructor: { collectionView, collection, indexPath in
            let cellView = collectionView.dequeueReusableCell(forType: FeedCollectionViewCell.self, for: indexPath)
            let item = collection![indexPath.row]
            return cellView
        }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.registerNib(withType: FeedCollectionViewCell.self)
        collectionView.dataSource = flatCollectionDataSource
        collectionView.backgroundColor = .white
    }
    
    func didSetViewModel(_ viewModel: FeedViewModel) {
        let output = viewModel.transform()
        output.posts
            .receive(on: DispatchQueue.main)
            .bind(subscriber: flatCollectionDataSource.subscriber(for: collectionView))
            .store(in: &subscriptions)
    }
    
}

// MARK: UICollectionViewDelegate
extension FeedViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let viewModel = layersViewModels[indexPath.row]
        guard let viewCell = collectionView.cellForItem(at: indexPath) as? FeedCollectionViewCell else { return }
        //        viewController.modalPresentationStyle = .custom
        //        viewController.modalPresentationCapturesStatusBarAppearance = true
        //        viewController.transitioningDelegate = transition
        //        present(viewController, animated: true, completion: nil)
    }
}
