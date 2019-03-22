//
//  ImageCollectionViewAdapter.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 22/03/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import UIKit

class ImageCollectionViewAdapter: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let cell = String(describing: ImageCollectionCell.self)
    private var images: [ResponseImage]
    
    init(collectionView: UICollectionView, images: [ResponseImage]) {
        collectionView.register(UINib(nibName: cell, bundle: .main), forCellWithReuseIdentifier: cell)
        self.images = images
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let imageCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: cell, for: indexPath) as? ImageCollectionCell else {
            fatalError("imgcolKek")
        }
        imageCollectionCell.setImage(respondImageURL: self.images[indexPath.row].image)
        return imageCollectionCell
    }
}
