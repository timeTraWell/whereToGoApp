//
//  DateParser.swift
//  whereToGoApp
//
//  Created by Nickolay Nickitin on 15/03/2019.
//  Copyright © 2019 Nickolay Nickitin. All rights reserved.
//

import Foundation

final class DateParser {
    
    static func getFormatedDate(intDate: Int) -> String? {
        let timeInterval = Double(intDate)
        
        let resultDate = Date(timeIntervalSince1970: timeInterval)
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.locale = Locale(identifier: "ru_RU")
        dateFormatterPrint.dateFormat = "dd MMMM"
        
        return dateFormatterPrint.string(from: resultDate)
    }
    
}
