//
//  FeedCollectionViewCell.swift
//  Reddit
//
//  Created by Andrew Chersky on 11.11.2020.
//

import UIKit

final class FeedCollectionViewCell: AnimatableCollectionViewCell {
    
    @IBOutlet private weak var activityView: UIActivityIndicatorView!
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var timestampLabel: UILabel!
    @IBOutlet private weak var commentsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor(red: .random(in: 0...255) / 255,
                                  green: .random(in: 0...255) / 255,
                                  blue: .random(in: 0...255) / 255,
                                  alpha: 1.0)
        
        layer.cornerRadius = frame.size.height / 50
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .init(width: 0, height: 4)
        layer.shadowRadius = 12
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        activityView.isHidden = false
        activityView.startAnimating()
    }
    
    public func setImage(_ image: UIImage?) {
        activityView.isHidden = true
        imageView.image = image
    }
    
}
