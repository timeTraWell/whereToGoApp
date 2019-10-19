//
//  CitiesExtension.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 05/09/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import Foundation

extension City {

    private enum Keys: String {
        case name = "name"
        case slug = "slug"
    }

    static func parse(json: Json) -> City? {
        
        guard let slug = json[Keys.slug.rawValue] as? String else {
            return nil
        }
        
        guard let name = json[Keys.name.rawValue] as? String else {
            return nil
        }
        
        return City(name: name, slug: slug)
    }
    
    var json: [String: Any] {
        
        var jsonObject = [String: Any]()
        
        jsonObject[Keys.name.rawValue] = self.name
        jsonObject[Keys.slug.rawValue] = self.slug
        
        return jsonObject
    }
    
}
