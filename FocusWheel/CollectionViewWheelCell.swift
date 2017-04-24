//
//  UICollectionViewWheelCell.swift
//  FocusWheel
//
//  Created by Nicholas Teissler on 4/23/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit

class CollectionViewWheelCell: UICollectionViewCell {
    var cellImage: UIImageView? {
        didSet {
            configureImage()
        }
    }
    
    override var reuseIdentifier: String? {
        return "WheelCell"
    }
    
    private func configureImage() {
        // uncomment for help visualizing the rotations involved in scrolling through the view
        //backgroundColor = UIColor.black
        guard let cellImage = cellImage else {
            return
        }
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        cellImage.frame = contentView.bounds
        contentView.addSubview(cellImage)
        
        NSLayoutConstraint(item: cellImage, attribute: .width, relatedBy: .lessThanOrEqual, toItem: self, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: cellImage, attribute: .height, relatedBy: .lessThanOrEqual, toItem: self, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: cellImage, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: cellImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        
        cellImage.adjustsImageWhenAncestorFocused = true
    }
}
