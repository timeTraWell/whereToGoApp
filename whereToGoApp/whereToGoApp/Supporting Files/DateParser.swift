//
//  DateParser.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 15/03/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import Foundation

final class DateParser {
    
    public static func getFormatedDate(intDate: Int) -> String {
        // convert Int to Double
        let timeInterval = Double(intDate)
        
        // create NSDate from Double (NSTimeInterval)
        let resultDate = Date(timeIntervalSince1970: timeInterval)
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss" // in this format date get from server
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.locale = Locale(identifier: "ru_RU")
        dateFormatterPrint.dateFormat = "dd MMMM"
        
        if dateFormatterGet.date(from: dateFormatterGet.string(from: resultDate)) != nil {
            return dateFormatterPrint.string(from: resultDate)
        } else {
            return "error"
        }
    }
}
