//
//  ViewController.swift
//  FocusWheel
//
//  Created by Nicholas Teissler on 4/23/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let images = [#imageLiteral(resourceName: "ios"), #imageLiteral(resourceName: "ux"), #imageLiteral(resourceName: "android"), #imageLiteral(resourceName: "mac"), #imageLiteral(resourceName: "frontend"), #imageLiteral(resourceName: "backend")]
    @IBOutlet var collectionView: WheelCollectionView!
    var scrollingAround = false
    var hasFocus = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CollectionViewWheelCell.self, forCellWithReuseIdentifier: "WheelCell")
        collectionView.dataSource = self
        collectionView.clipsToBounds = false
        collectionView.delegate = self
        collectionView.remembersLastFocusedIndexPath = true
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WheelCell", for: indexPath) as! CollectionViewWheelCell
        let image = images[indexPath.row]
        let imageView = UIImageView(image: image)
        cell.cellImage = imageView
        
        return cell
    }

}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pushSplitViewController(for: indexPath)
        scrollingAround = false
        setNeedsFocusUpdate()
    }
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return scrollingAround || !hasFocus
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        hasFocus = context.nextFocusedIndexPath != nil
        scrollingAround = context.nextFocusedIndexPath != nil
    }
    
    private func pushSplitViewController(for indexPath: IndexPath) {
        guard let placeholderViewController = storyboard?.instantiateViewController(withIdentifier: "ColorViewController") as? ColorViewController, let splitViewController = splitViewController  else {
            return
        }
        let color: UIColor
        switch (indexPath.row) {
        case 0:
            color = UIColor(colorLiteralRed: 33/255, green: 173/255, blue: 251/255, alpha: 0.6)
        case 1:
            color = UIColor.purple.withAlphaComponent(0.6)
        case 2:
            color = UIColor(colorLiteralRed: 118/255, green: 199/255, blue: 44/255, alpha: 0.6)
        case 3:
            color = UIColor.white.withAlphaComponent(0.6)
        case 4:
            color = UIColor.red.withAlphaComponent(0.6)
        case 5:
            color = UIColor.orange.withAlphaComponent(0.6)
        default:
            color = UIColor.black
        }
        placeholderViewController.cellColor = color
        splitViewController.showDetailViewController(placeholderViewController, sender: self)
    }
}
