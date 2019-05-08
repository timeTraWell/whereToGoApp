//
//  ResponsePlace.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 08/05/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import Foundation

class ResponsePlace: Codable {
    let address: String
    let coords: ResponseCoordinates
}
