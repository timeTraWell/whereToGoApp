//
//  Event.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 04/03/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import Foundation

class Event: Codable {
    let id: Int
    let title: String
    let price: String
    let description: String
    let dates: [ResponseDate]
    let images: [ResponseImage]
}

class ResponseDate: Codable {
    let start: Int
    let end: Int
    
}

class ResponseImage: Codable {
    let image: String
}
