//
//  Data.swift
//  Social Hues
//
//  Created by Daniel Kim on 5/22/18.
//  Copyright © 2018 Sarah Zhou. All rights reserved.
//

import Foundation

class InMemData {
    var me: Contact?
    var myEvents = [Event]()
    var friends = [Contact]()
    var eventDB =
        ["0": Event(code: "0", title: "CSE 441 Showcase", date: DateComponents(calendar: Calendar(identifier: .gregorian), timeZone: nil, era: nil, year: 2018, month: 6, day: 5, hour: 2, minute: 30, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil), location: "Ode 141"),
         "1": Event(code: "1", title: "Dawg Daze", date: DateComponents(calendar: Calendar(identifier: .gregorian), timeZone: nil, era: nil, year: 2018, month: 9, day: 25, hour: 7, minute: 0, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil), location: "Red Square"),
         "2": Event(code: "2", title: "Alder Floor 6 Meeting", date: DateComponents(calendar: Calendar(identifier: .gregorian), timeZone: nil, era: nil, year: 2018, month: 10, day: 20, hour: 6, minute: 30, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil), location: "Floor 6 TV Lounge")]
    
}
