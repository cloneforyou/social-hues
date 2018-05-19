//
//  AddEventViewController.swift
//  Social Hues
//
//  Created by Daniel Kim on 5/18/18.
//  Copyright © 2018 Social Hues. All rights reserved.
//

import UIKit

class AddEventViewController : UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let addEventView = AddEventView()
//        self.view.addSubview(addEventView)
//    }
    
    
    var popup = AddEventView()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(rgb: 0x0A1C3F)
        popup = AddEventView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        
        
        
        popup.translatesAutoresizingMaskIntoConstraints = true
        popup.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        popup.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
        
        self.view.addSubview(popup)
        
    }
}
