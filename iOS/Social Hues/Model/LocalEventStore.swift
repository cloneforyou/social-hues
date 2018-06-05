//
//  LocalEventStore.swift
//  Social Hues
//
//  Created by Daniel Kim on 6/4/18.
//  Copyright © 2018 Sarah Zhou. All rights reserved.
//

import Foundation
import UIKit

class LocalEventStore {
    static let prompts = ["What's your favorite part about this class?",
                              "What was the most challenging aspect of your design and implementation process?",
                              "What excites you most about your project?",
                              "What changes would you suggest to the course?"]
    static let colors = [UIColor.red, UIColor.green, UIColor.blue]
    static let eventDB = ["0": Event(code: "0",
                                     title: "CSE 441 Showcase",
                                     date: DateComponents(calendar: Calendar(identifier: .gregorian), timeZone: nil, era: nil, year: 2018, month: 6, day: 5, hour: 1, minute: 57, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil),
                                     location: "Ode 141",
                                     prompts: prompts,
                                     groups: 3,
                                     colors: colors),
                          "1": Event(code: "1",
                                     title: "Dawg Daze",
                                     date: DateComponents(calendar: Calendar(identifier: .gregorian), timeZone: nil, era: nil, year: 2018, month: 9, day: 25, hour: 7, minute: 0, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil),
                                     location: "Red Square",
                                     prompts: prompts,
                                     groups: 3,
                                     colors: colors),
                          "2": Event(code: "2",
                                     title: "Alder Floor 6 Meeting",
                                     date: DateComponents(calendar: Calendar(identifier: .gregorian), timeZone: nil, era: nil, year: 2018, month: 10, day: 20, hour: 6, minute: 30, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil),
                                     location: "Floor 6 TV Lounge",
                                     prompts: prompts,
                                     groups: 3,
                                     colors: colors)]
}
