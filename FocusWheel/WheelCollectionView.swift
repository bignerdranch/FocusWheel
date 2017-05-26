//
//  WheelCollectionView.swift
//  FocusWheel
//
//  Created by Nicholas Teissler on 5/24/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit

class WheelCollectionView: UICollectionView {
    
    
    var orientationRadians: CGFloat = 0.0 {
        didSet {
            transform = CGAffineTransform(rotationAngle: orientationRadians)
        }
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        guard let cell = context.nextFocusedView as? CollectionViewWheelCell,
            let index = indexPath(for: cell) else {
                return
        }
        
        coordinator.addCoordinatedAnimations({
            // Adjust the animation speed following Apple's guidelines:
            // https://developer.apple.com/reference/uikit/uifocusanimationcoordinator
            let duration : TimeInterval = UIView.inheritedAnimationDuration;
            UIView.animate(withDuration: (4.0*duration), delay: 0.0, options: .overrideInheritedDuration, animations: {
                self.scrollToItem(at: index, at: .right, animated: true)
            }, completion: nil)
        }, completion: nil)
    }
    
    override func scrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionViewScrollPosition, animated: Bool) {
        let n = CGFloat(numberOfItems(inSection: indexPath.section))
        let index = CGFloat(indexPath.row)
        let radians = .pi * (2.0 - (2.0 * index + 1) / n)
        orientationRadians = radians
        
        for cell in self.visibleCells as! [CollectionViewWheelCell] {
            cell.cellImage?.transform = CGAffineTransform(rotationAngle: -CGFloat(radians))
        }
    }
}
