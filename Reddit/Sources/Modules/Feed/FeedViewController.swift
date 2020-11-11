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
        
        
    }


}

// MARK: ViewControllers
private extension FeedViewController {
    
}

// MARK: UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
typealias CollectionProtocols = UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
extension FeedViewController: CollectionProtocols {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let rawView = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCollectonViewCell", for: indexPath)
        let cellView = rawView as? FeedCollectonViewCell
        return cellView ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewsOnDisplay: CGFloat = 1.5
        return CGSize(width: collectionView.frame.size.width / viewsOnDisplay,
                      height: collectionView.frame.size.height / viewsOnDisplay)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let viewModel = layersViewModels[indexPath.row]
        guard let viewCell = collectionView.cellForItem(at: indexPath) as? FeedCollectonViewCell else { return }
        transition = Transition(cell: viewCell)
//        viewController.modalPresentationStyle = .custom
//        viewController.modalPresentationCapturesStatusBarAppearance = true
//        viewController.transitioningDelegate = transition
//        present(viewController, animated: true, completion: nil)
    }
}
