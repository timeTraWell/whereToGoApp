//
//  Fonts.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 22/02/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import UIKit

final class Fonts {
    
    //MARK:- fonts names list
    //SFProDisplay-Medium, SFProText-Bold, SFProText-Regular, SFProText-Semibold
    static func getFont(fontName: String, size: CGFloat) -> UIFont? {
        return UIFont(name: fontName, size: size)
    }
    
}
