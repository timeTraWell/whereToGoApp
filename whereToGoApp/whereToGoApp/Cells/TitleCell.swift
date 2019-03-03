//
//  TitleCell.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 22/02/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import UIKit

class TitleCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
//        test()
        titleLabel.contentMode = .bottom
        titleLabel.font = Fonts.titleFont
        titleLabel.textColor = Color.black
    }
    
//    func test() {
//        for name in UIFont.familyNames {
//            print(name)
//            if let nameString = name as? String
//                
//            {
//                
//                print(UIFont.fontNames(forFamilyName: nameString))
//            }
//        }
//    }

}
