//
//  File.swift
//  Social Hues
//
//  Created by Daniel Kim on 5/20/18.
//  Copyright © 2018 Social Hues. All rights reserved.
//

import Foundation

class Event {
    var code: String
    var title: String
    var date: DateComponents
    var location: String
    var monthString: String
    var dayString: String
    var calendar: Calendar
    var detailsString: String
    
    init(code: String, title: String, date: DateComponents, location: String) {
        self.code = code
        self.title = title
        self.date = date
        self.location = location
        self.calendar = Calendar(identifier: .gregorian)
        self.monthString = ""
        
        self.dayString = String(date.day!)
        if dayString.count == 1 {
            self.dayString = "0" + dayString
        }
        
        var minuteString = String(date.minute!)
        if minuteString.count == 1 {
            minuteString = "0" + minuteString
        }
        
        self.detailsString = String(date.hour!) + ":" + minuteString + " @" + location
        self.monthString = findMonthString(date.month!)
    }
    
    func findMonthString(_ month: Int) -> String {
        switch month {
        case 1:
            return "JAN"
        case 2:
            return "FEB"
        case 3:
            return "MARCH"
        case 4:
            return "APRIL"
        case 5:
            return "MAY"
        case 6:
            return "JUNE"
        case 7:
            return "JULY"
        case 8:
            return "AUG"
        case 9:
            return "SEPT"
        case 10:
            return "OCT"
        case 11:
            return "NOV"
        case 12:
            return "DEC"
        default:
            return ""
        }
    }
}
