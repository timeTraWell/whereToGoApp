//
//  EventsService.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 04/03/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import Foundation
import Alamofire

enum Result<ResultDataType> {
    case data(ResultDataType)
    case error(ServiceError)
}

enum ServiceError: LocalizedError {
    case resultsMissing
    case dataMissing
    case noResult
    case serializeCrash
    case mappingCrash
    
    var errorDescription: String? {
        switch self {
        case .resultsMissing:
            return "result is missing"
        case .noResult:
            return "no results"
        case .dataMissing:
            return "data missing"
        case .serializeCrash:
            return "data serialization error"
        case .mappingCrash:
            return "data mapping error"
        }
    }
}


class EventsService {
    
    func loadEvents(eventsCount: Int, citySlug: String, completion: @escaping (Result<[Event]>) -> Void) {
        let actualDate = getActualDate()
        let url = "https://kudago.com/public-api/v1.4/events/?fields=id,dates,place,images,price,title,description,body_text&actual_since=\(actualDate)&expand=place&page_size=\(eventsCount)&text_format=text&location=\(citySlug)"
        Alamofire.request(url, method: .get).responseJSON { response in
            guard response.result.isSuccess else {
                return completion(.error(.noResult))
            }
            
            guard let json = response.result.value as? [String: Any] else {
                return completion(.error(.dataMissing))
            }
                
            guard let resultsEvents = json["results"]  else {
                return completion(.error(.resultsMissing))
            }
                
            guard let data = try? JSONSerialization.data(withJSONObject: resultsEvents, options: JSONSerialization.WritingOptions.prettyPrinted) else {
                return completion(.error(.serializeCrash))
            }
                
            guard let events = try? JSONDecoder().decode([Event].self, from: data) else {
                return completion(.error(.mappingCrash))
            }
            
            return completion(.data(events))
        }
    }
    
    //MARK:- Private helper
    private func getActualDate() -> Int {
        let someDate = Date()
        let timeInterval = someDate.timeIntervalSince1970
        return Int(timeInterval)
    }
}
