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
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CollectionViewWheelCell.self, forCellWithReuseIdentifier: "WheelCell")
        collectionView.dataSource = self
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
