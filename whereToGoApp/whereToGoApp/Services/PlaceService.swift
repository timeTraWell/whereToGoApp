//
//  PlaceService.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 04/09/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import Foundation
import Alamofire

class PlaceService {
    
    func loadCities(completion: @escaping (Result<[City]>) -> Void) {
        let url = "https://kudago.com/public-api/v1.4/locations/?fields=name,slug&order_by=name&lang=ru"
        
        Alamofire.request(url, method: .get).responseJSON { response in
            guard response.result.isSuccess else {
                return completion(.error(.noResult))
            }
        
            guard let json = response.result.value as? [Any] else {
                return completion(.error(.dataMissing))
            }
            
            guard let data = try? JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) else {
                    return completion(.error(.serializeCrash))
            }
            
            guard let cities = try? JSONDecoder().decode([City].self, from: data) else {
                return completion(.error(.mappingCrash))
            }
            
            return completion(.data(cities))
        }
    }
}
