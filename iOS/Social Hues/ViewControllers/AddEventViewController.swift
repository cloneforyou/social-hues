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
    func addEventButtonPressed(code: String)
}

class AddEventViewController : UIViewController {
    var popup: AddEventView?
    var delegate: EventsTableViewControllerDelegate?
    
    init(delegate: EventsTableViewControllerDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.423529, green: 0.454902, blue: 0.517647, alpha: 1)
        
        
        // add event modal
        let newPopup = AddEventView(frame: CGRect(x: 0, y: 0, width: 317, height: 241), addEventDelegate:self)
        newPopup.translatesAutoresizingMaskIntoConstraints = true
        newPopup.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY - 40)
        newPopup.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
        self.popup = newPopup
        self.view.addSubview(popup!)
        
        // add keyboard view
        
    }
    
//    @IBAction func goBackToOneButtonTapped(_ sender: Any) {
//        performSegue(withIdentifier: "unwindSegueToVC1", sender: self)
//    }
}

extension AddEventViewController : AddEventViewDelegate {
    func closeAddEventPopup() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addEventButtonPressed(code: String) {
        self.delegate?.addEvent(code: code)
        self.dismiss(animated: true, completion: nil)
        // TODO: add event sent to servers
        // TODO: event added confirmation
        // TODO: refresh event list
    }
}


