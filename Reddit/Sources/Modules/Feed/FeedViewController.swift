//
//  FeedViewController.swift
//  Reddit
//
//  Created by Andrew Chersky on 10.11.2020.
//

import UIKit
import Combine

final class FeedViewController: UIViewController, ViewModelContainer {
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var flatCollectionDataSource = FlatCollectionViewDataSource<[String]>(
        cellConstructor: { $0.dequeueReusableCell(forType: FeedCollectionViewCell.self, for: $1) }
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
