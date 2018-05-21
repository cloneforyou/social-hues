//
//  File.swift
//  Social Hues
//
//  Created by Daniel Kim on 5/20/18.
//  Copyright © 2018 Sarah Zhou. All rights reserved.
//

import Foundation

class FakeEventStore {
    private var prototypeEventDB: [String: Event]
    
    init() {
        self.prototypeEventDB = [String: Event]()
        
        self.prototypeEventDB["0"] = Event(code: "0", title: "CSE 441 Showcase", month: "JUNE", day: "05", details: "2:30pm @Ode 141")
        self.prototypeEventDB["1"] = Event(code: "1", title: "Design Majors Party", month: "MAR", day: "23", details: "9pm @Art Building")
    }
    
    func getEvent(code: String) -> Event {
        return self.prototypeEventDB[code]!
    }
}
