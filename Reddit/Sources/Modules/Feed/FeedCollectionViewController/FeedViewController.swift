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
    
    private lazy var flatCollectionDataSource = FlatCollectionViewDataSource<[Child]>(
        cellConstructor: { [unowned self] collectionView, collection, indexPath in
            let cellView = collectionView.dequeueReusableCell(forType: FeedCollectionViewCell.self, for: indexPath)
            let item = collection![indexPath.row]
            let reusableViewModel = FeedCollectionCellViewModel(
                useCases: self.viewModel.useCases,
                title: item.title,
                author: item.author,
                date: item.createdUtc,
                imageURL: item.url,
                commentsNumber: item.numComments
            )
            cellView.viewModel = reusableViewModel
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
        
        let indexPathPublisher = collectionView
            .publisher(for: \.contentOffset, options: [.new])
            .compactMap { [weak self] contentOffset -> CGRect? in
                guard let self = self else { return nil }
                return CGRect(origin: contentOffset, size: self.collectionView.bounds.size)
            }
            .map { CGPoint(x: $0.midX, y: $0.midY) }
            .compactMap { [weak self] in self?.collectionView.indexPathForItem(at: $0 ) }
            .map(\.row)
            .filter { $0 == self.collectionView.numberOfItems(inSection: 0) / 2 }
            .debounce(for: 2.0, scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
        
        let input = FeedViewModel.Input(indexPath: indexPathPublisher)        
        let output = viewModel.transform(input)
        
        _ = output.collection
            .map { !$0.isEmpty }
            .assign(to: \.isHidden, on: activityIndicator)
        
        output.collection
            .bind(subscriber: flatCollectionDataSource.subscriber(for: collectionView))
            .store(in: &subscriptions)
        
    }
    
}

// MARK: UICollectionViewDelegate
extension FeedViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let viewCell = collectionView.cellForItem(at: indexPath) as? FeedCollectionViewCell,
            let viewModel = viewCell.viewModel else { return }
        self.viewModel.handlers.openDetails.send((viewModel.imageURL, viewCell))
    }
}
