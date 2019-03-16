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
    let body_text: String
    let dates: [ResponseDate]?
    let images: [ResponseImage]
    let place: ResponsePlace?
}

class ResponseDate: Codable {
    let start: Int
    let end: Int
    
}

class ResponseImage: Codable {
    let image: String
}

class ResponsePlace: Codable {
    let address: String
    let coords: ResponseCoordinates
}

class ResponseCoordinates: Codable {
    let lat: Double
    let lon: Double
}
