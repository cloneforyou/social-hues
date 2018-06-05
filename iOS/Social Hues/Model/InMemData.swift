//
//  Data.swift
//  Social Hues
//
//  Created by Daniel Kim on 5/22/18.
//  Copyright © 2018 Sarah Zhou. All rights reserved.
//

import Foundation
import UIKit

class InMemData {
    var me: Contact?
    var myEvents: [Event]
    var friends: [Contact]
    var icebreakers: [String: Icebreaker]
        
    init() {
        myEvents = [Event]()
        friends = [Contact]()
        icebreakers = [String: Icebreaker]()
    }
    
    static func getData() -> InMemData {
        return (UIApplication.shared.delegate as! AppDelegate).data
    }
}
