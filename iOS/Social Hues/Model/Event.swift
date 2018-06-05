//
//  File.swift
//  Social Hues
//
//  Created by Daniel Kim on 5/20/18.
//  Copyright © 2018 Social Hues. All rights reserved.
//

import Foundation
import UIKit

class Event {
    var code: String
    var title: String
    var date: DateComponents
    var location: String
    var monthString: String
    var dayString: String
    var calendar: Calendar
    var detailsString: String
    var prompts: [String]
    var groups: Int
    var colors: [UIColor]
    
    init(code: String, title: String, date: DateComponents, location: String, prompts: [String], groups: Int, colors: [UIColor]) {
        self.code = code
        self.title = title
        self.date = date
        self.location = location
        self.calendar = Calendar(identifier: .gregorian)
        self.monthString = ""
        self.prompts = prompts
        self.groups = groups
        self.colors = colors
        
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
    
    func getNextIndex(curr: Int) -> Int {
        if curr == prompts.count {
            return 0
        }
        return curr + 1
    }
    
    func getNextColor(currColor: UIColor?) -> UIColor {
        guard let notColor = currColor else {
            return pickRandomColor()
        }
        
        var next = pickRandomColor()
        while (notColor.isEqual(next)) {
            next = pickRandomColor()
        }
        return next
    }
    
    func pickRandomColor() -> UIColor {
        return colors[Int(arc4random_uniform(UInt32(colors.count)))]
    }
    
    func firstColor() -> Int {
        return 0
    }
}
