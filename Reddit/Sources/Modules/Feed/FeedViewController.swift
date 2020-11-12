//
//  FeedViewController.swift
//  Reddit
//
//  Created by Andrew Chersky on 10.11.2020.
//

import UIKit


//struct ViewModel {
//
//    struct Input {
//
//    }
//
//    struct Output {
//
//    }
//
//    func load() {
//
//    }
//
//}

final class FeedViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var transition: Transition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.registerNib(withType: FeedCollectionViewCell.self)
        collectionView.backgroundColor = .white
    }


}

// MARK: ViewControllers
private extension FeedViewController {
    
}

// MARK: UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
typealias CollectionProtocols = UICollectionViewDelegate & UICollectionViewDataSource
extension FeedViewController: CollectionProtocols {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(forType: FeedCollectionViewCell.self, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let viewModel = layersViewModels[indexPath.row]
        guard let viewCell = collectionView.cellForItem(at: indexPath) as? FeedCollectionViewCell else { return }
        transition = Transition(cell: viewCell)
//        viewController.modalPresentationStyle = .custom
//        viewController.modalPresentationCapturesStatusBarAppearance = true
//        viewController.transitioningDelegate = transition
//        present(viewController, animated: true, completion: nil)
    }
}
