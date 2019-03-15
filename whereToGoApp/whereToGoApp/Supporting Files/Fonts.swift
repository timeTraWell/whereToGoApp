//
//  Fonts.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 22/02/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import UIKit

final class Fonts {
    
    static let titleFont = UIFont(name: "SFProDisplay-Medium", size: 30)
    static let SFProText16 = UIFont(name: "SFProText-Bold", size: 16)
    static let SFProText14 = UIFont(name: "SFProText-Regular", size: 14)
    static let SFProText16Reg = UIFont(name: "SFProText-Regular", size: 16)
    static let SFProText20 = UIFont(name: "SFProText-Bold", size: 20)
    static let SFProTextSemibold = UIFont(name: "SFProText-Semibold", size: 16)
    
    static func getFont(fontName: String, size: CGFloat) -> UIFont? {
        return UIFont(name: fontName, size: size)
    }
}
