//
//  Icebreakers.swift
//  Social Hues
//
//  Created by Daniel Kim on 6/4/18.
//  Copyright © 2018 Sarah Zhou. All rights reserved.
//

import Foundation
import UIKit

class Icebreaker {
    // active event instance
    var currColor: UIColor
    var currTimeLeft: Int
    var timer: Timer?
    var event: Event
    weak var delegate: PromptViewControllerDelegate?
    var currPromptIndex: Int
    
    let maxDuration = 180 // seconds
    
    init(event: Event) {
        self.currColor = event.getNextColor(currColor: nil)
        self.currTimeLeft = maxDuration
        self.event = event
        self.currPromptIndex = 0
        self.timer = Timer(fire: event.date.date!, interval: 1, repeats: true, block: updateTime)
        RunLoop.current.add(timer!, forMode: .commonModes)
    }
    
    func updateTime(timer: Timer) {
        currTimeLeft -= 1
        if currTimeLeft == 0 {
            currTimeLeft = maxDuration
            currColor = self.event.getNextColor(currColor: currColor)
            currPromptIndex = self.event.getNextIndex(curr: currPromptIndex)
            delegate?.startNewPrompt(currColor, newPrompt: self.event.prompts[currPromptIndex])
        }
        delegate?.updateTimeLabel(time: currTimeLeft)
    }
}
