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
        collectionView.backgroundColor = .white
    }
    
    func didSetViewModel(_ viewModel: FeedViewModel) {
        let output = viewModel.transform()
        
    }
    
}

//// MARK: UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
//typealias CollectionProtocols = UICollectionViewDelegate & UICollectionViewDataSource
//extension FeedViewController: CollectionProtocols {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        return collectionView.dequeueReusableCell(forType: FeedCollectionViewCell.self, for: indexPath)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        //        let viewModel = layersViewModels[indexPath.row]
//        guard let viewCell = collectionView.cellForItem(at: indexPath) as? FeedCollectionViewCell else { return }
//        //        viewController.modalPresentationStyle = .custom
//        //        viewController.modalPresentationCapturesStatusBarAppearance = true
//        //        viewController.transitioningDelegate = transition
//        //        present(viewController, animated: true, completion: nil)
//    }
//}
