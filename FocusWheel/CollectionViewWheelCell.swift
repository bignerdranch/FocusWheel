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
        cellImage.frame = contentView.bounds
        contentView.addSubview(cellImage)
        
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        cellImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        cellImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cellImage.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        cellImage.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        cellImage.adjustsImageWhenAncestorFocused = true
    }
}
