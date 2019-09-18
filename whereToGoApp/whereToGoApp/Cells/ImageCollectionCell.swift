//
//  ImageCollectionCell.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 22/03/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import UIKit

class ImageCollectionCell: UICollectionViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var imageContainer: UIImageView!
    
    //MARK:- UICollectionViewCell
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setImage(respondImageURL: String) {
            if let imageURL = URL(string: respondImageURL), let placeholder = UIImage(named: "defaultImg") {
                self.imageContainer.af_setImage(withURL: imageURL, placeholderImage: placeholder)
            }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageContainer.image = nil
    }
    
}
