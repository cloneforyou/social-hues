//
//  Contact.swift
//  Social Hues
//
//  Created by Daniel Kim on 5/22/18.
//  Copyright © 2018 Sarah Zhou. All rights reserved.
//

import Foundation

class Contact {
    var firstName: String
    var lastName: String
    var email: String
    var phone: String
    
    init(first: String, last: String, email: String, phone: String) {
        self.firstName = first
        self.lastName = last
        self.email = email
        self.phone = phone
        
    }
    
    convenience init(qrString: String) {
        let fields = qrString.split(separator: ",")
        self.init(first: String(fields[0]), last: String(fields[1]), email: String(fields[2]), phone: String(fields[3]))
    }
    
    static func isContactString(qrString: String) -> Bool {
        let fields = qrString.split(separator: ",")
        return fields.count == 4
    }
    
    func qrString() -> String {
        return firstName + "," + lastName + "," + email + "," + phone
    }
}
