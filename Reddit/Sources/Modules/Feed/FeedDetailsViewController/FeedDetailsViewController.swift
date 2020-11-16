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
    
    func didSetViewModel(_ viewModel: FeedDetailsViewModel) {
        
    }
    
}
