//
//  ImageCollectionViewAdapter.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 22/03/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import UIKit

class ImageCollectionViewAdapter: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK:- Private properties
    private let cell = String(describing: ImageCollectionCell.self)
    private var images: [ResponseImage]
    private var pageControl: UIPageControl
    
    //MARK:- Init
    init(collectionView: UICollectionView, images: [ResponseImage], imageControl: UIPageControl) {
        collectionView.register(UINib(nibName: cell, bundle: .main), forCellWithReuseIdentifier: cell)
        self.images = images
        self.pageControl = imageControl
    }
    
    //MARK:- UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let imageCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: cell, for: indexPath) as? ImageCollectionCell else {
            return UICollectionViewCell()
        }
        imageCollectionCell.setImage(respondImageURL: self.images[indexPath.row].image)
        return imageCollectionCell
    }
    
    //MARK:- UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let currentCellIndex = collectionView.indexPathsForVisibleItems[0][1]
        if (currentCellIndex > pageControl.numberOfPages) {
            pageControl.currentPage = pageControl.numberOfPages
        } else {
            pageControl.currentPage = currentCellIndex
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 260)
    }
}
