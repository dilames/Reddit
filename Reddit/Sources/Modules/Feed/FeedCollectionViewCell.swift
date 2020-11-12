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
        
        contentView.backgroundColor = UIColor(red: .random(in: 0...255) / 255,
                                              green: .random(in: 0...255) / 255,
                                              blue: .random(in: 0...255) / 255,
                                              alpha: 1.0)
        
        contentView.layer.cornerRadius = 10.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .init(width: 0, height: 2)
        layer.shadowRadius = 6
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard layer.shadowPath == .none else { return }
        layer.shadowPath = UIBezierPath(roundedRect: bounds,
                                        cornerRadius: contentView.layer.cornerRadius).cgPath
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
