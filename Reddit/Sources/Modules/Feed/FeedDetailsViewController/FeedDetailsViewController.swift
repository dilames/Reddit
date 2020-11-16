//
//  FeedDetailsViewController.swift
//  Reddit
//
//  Created by Andrew Chersky on 16.11.2020.
//

import Foundation
import UIKit
import Platform

final class FeedDetailsViewController: UIViewController, ViewModelContainer {
    
    @IBOutlet private var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func didSetViewModel(_ viewModel: FeedDetailsViewModel) {
        let output = viewModel.transform(())
        output.imageData
            .map { UIImage(data: $0) }
            .receive(on: DispatchQueue.main)
            .replaceError(with: UIImage(named: "test-image")!)
            .assign(to: \.image, on: imageView)
            .store(in: &subscriptions)
    }
    
}
