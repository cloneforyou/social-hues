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
    var month: String
    var day: String
    var details: String
    
    init(code: String, title: String, month: String, day: String, details: String) {
        self.code = code
        self.title = title
        self.month = month
        self.day = day
        self.details = details
    }
}
