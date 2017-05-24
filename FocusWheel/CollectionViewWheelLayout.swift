//
//  CollectionViewWheelLayout.swift
//  FocusWheel
//
//  Created by Nicholas Teissler on 4/23/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit

class CollectionViewWheelLayout: UICollectionViewLayout {

    var itemSpacingDegrees: CGFloat = 3.0
    
    lazy var configureLayout: Void = {
        guard self.itemAttributesCache.isEmpty, let collectionView = self.collectionView else { return }
        for section in 0..<collectionView.numberOfSections {
            let itemCount = collectionView.numberOfItems(inSection: section)
            let cgItemCount = CGFloat(itemCount)
            
            // create a layout attribute for each cell of our collection view
            for i in 0..<itemCount {
                let bounds = collectionView.bounds
                let O = CGPoint(x: bounds.midX, y: bounds.midY)
                let R = bounds.width / 2.0
                let radiansSoFar = CGFloat((i * 360/itemCount)).degreesToRadians
                let endAngle = radiansSoFar + (360.0/cgItemCount - self.itemSpacingDegrees).degreesToRadians
                let θ = (endAngle - radiansSoFar)
                let r = (R * sin(θ/2.0)) / (sin(θ/2.0) + 1)
                let OC = R - r 
                let x = cos(radiansSoFar + θ / 2.0) * OC - r + O.x
                let y = sin(radiansSoFar + θ / 2.0) * OC - r + O.y
                let frameOrigin = CGPoint(x: x, y: y)
                let cellFrame = CGRect(origin: frameOrigin, size: CGSize(width: 2*r, height: 2*r))
                
                let indexPath = IndexPath(item: i, section: section)
                let layoutAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                layoutAttributes.frame = cellFrame
                self.itemAttributesCache.append(layoutAttributes)
            }
        }
    }()

    var itemAttributesCache = [UICollectionViewLayoutAttributes]()
    
    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else {
            preconditionFailure("Requested content size for CollectionViewDialLayout with associated Collection View")
        }
        return collectionView.frame.size
    }
    
    override func prepare() {
        _ = configureLayout
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        itemAttributesCache = []
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let itemAttributes = itemAttributesCache.filter {
            $0.frame.intersects(rect)
        }
        return itemAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return itemAttributesCache.first {
            $0.indexPath == indexPath
        }
    }

}

// MARK: - Number type extensions
extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}
extension CGFloat {
    var degreesToRadians: CGFloat { return self * .pi / 180 }
}
