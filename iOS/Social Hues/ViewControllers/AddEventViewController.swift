//
//  AddEventViewController.swift
//  Social Hues
//
//  Created by Daniel Kim on 5/18/18.
//  Copyright © 2018 Social Hues. All rights reserved.
//

import UIKit

protocol AddEventViewDelegate {
    func closeAddEventPopup()
}

class AddEventViewController : UIViewController {
    var popup: AddEventView?
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(rgb: 0x0A1C3F)
        
        // add event modal
        let newPopup = AddEventView(frame: CGRect(x: 0, y: 0, width: 317, height: 241), addEventDelegate:self)
        newPopup.translatesAutoresizingMaskIntoConstraints = true
        newPopup.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        newPopup.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
        self.popup = newPopup
        self.view.addSubview(popup!)
        
        
    }
    
//    @IBAction func goBackToOneButtonTapped(_ sender: Any) {
//        performSegue(withIdentifier: "unwindSegueToVC1", sender: self)
//    }
}

extension AddEventViewController : AddEventViewDelegate {
    func closeAddEventPopup() {
        //performSegue(withIdentifier: "returnToEvents", sender: self)
        //print("close")
        //self.navigationController?.popViewController(animated: true)
    }
    
    func addEventButtonPressed() {
        self.dismiss(animated: true, completion: nil)
        // TODO: add event sent to servers
        // TODO: event added confirmation
        // TODO: refresh event list
    }
}


