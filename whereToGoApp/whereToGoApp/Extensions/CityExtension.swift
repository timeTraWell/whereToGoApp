//
//  CitiesExtension.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 05/09/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import Foundation

extension City {
    
    static func parse(json: [String: Any]) -> City? {
        
        guard let slug = json["slug"] as? String else {
            return nil
        }
        
        guard let name = json["name"] as? String else {
            return nil
        }
        
        return City(name: name, slug: slug)
    }
    
    var json: [String: Any] {
        
        var jsonObject = [String: Any]()
        
        jsonObject["name"] = self.name
        jsonObject["slug"] = self.slug
        
        return jsonObject
    }
}
