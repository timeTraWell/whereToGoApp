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
    case error(String)
}


class EventsService {
    
    func loadEvents(eventsCount: String, completion: @escaping (Result<[Event]>) -> Void) {
        let url = "https://kudago.com/public-api/v1.4/events/?fields=id,dates,place,images,price,title,description,body_text&expand=place&page_size=\(eventsCount)&text_format=text&location=msk"
        Alamofire.request(url, method: .get).responseJSON { response in
            guard response.result.isSuccess else {
                return completion(.error("Ошибка при запросе данных \(String(describing: response.result.error))"))
            }
            
            guard let json = response.result.value as? [String: Any] else {
                return completion(.error("data response error"))
            }
                
            guard let resultsEvents = json["results"]  else {
                return completion(.error("results in response missing"))
            }
                
            guard let data = try? JSONSerialization.data(withJSONObject: resultsEvents, options: JSONSerialization.WritingOptions.prettyPrinted) else {
                return completion(.error("serialize error"))
            }
                
            guard let events = try? JSONDecoder().decode([Event].self, from: data) else {
                return completion(.error("mapping error"))
            }
            return completion(.data(events))
        }
    }
}
