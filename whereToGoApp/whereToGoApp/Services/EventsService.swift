//
//  EventsService.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 04/03/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import Foundation
import Alamofire

typealias Json = [String : Any]
typealias resultCompletion = (Result<[Event]>) -> Void

enum Result<ResultDataType> {
    case data(ResultDataType)
    case error(ServiceError)
}
enum BaseRoute {
    static let base = "https://kudago.com/public-api/v1.4"
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


final class EventsService {

    // MARK: - Constants

    private enum Constants {
        static let url = "/events/?fields=id,dates,place,images,price,title,description,body_text&expand=place"
        static let textFormat = "&text_format=text"
        static let results = "results"
    }
    func loadEvents(eventsCount: Int, page: Int, citySlug: String, completion: @escaping resultCompletion) {
        let url = formUrl(eventsCount: eventsCount, page: page, citySlug: citySlug)

        Alamofire.request(url, method: .get).responseJSON { response in
            guard response.result.isSuccess else {
                return completion(.error(.noResult))
            }
            
            guard let json = response.result.value as? [String: Any] else {
                return completion(.error(.dataMissing))
            }
                
            guard let resultsEvents = json[Constants.results]  else {
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
    
    // MARK: - Private helper
    
    private func getActualDate() -> Int {
        let someDate = Date()
        let timeInterval = someDate.timeIntervalSince1970
        return Int(timeInterval)
    }

    private func formUrl(eventsCount: Int, page: Int, citySlug: String) -> String {
        let pageSize = "&page_size=" + "\(eventsCount)"
        let page = "&page=" + "\(page)"
        let location = "&location=" + "\(citySlug)"
        return BaseRoute.base + Constants.url + pageSize + page + Constants.textFormat + location
    }
}
