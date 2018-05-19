//
//  AddEventView.swift
//  Social Hues
//
//  Created by Daniel Kim on 5/19/18.
//  Copyright © 2018 Sarah Zhou. All rights reserved.
//

import UIKit

@IBDesignable
class AddEventView: UIView {
    var closeButton = UIButton()
    var label = UILabel()
    
    // if cornerRadius variable is set/changed, change the corner radius of the UIView
//    @IBInspectable var cornerRadius: CGFloat = 13 {
//        didSet {
//            layer.cornerRadius = cornerRadius
//            layer.masksToBounds = cornerRadius > 0
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        layer.cornerRadius = 13
        layer.masksToBounds = true
        
        label.text = "Hello World!"
        label.textColor = .black
        label.backgroundColor = .gray
        label.frame = CGRect(x: self.bounds.maxX - 20, y: self.bounds.maxY - 20, width: 17, height: 17)
        self.addSubview(label)
        //self.bounds.
        
        //popup.translatesAutoresizingMaskIntoConstraints = true
//        popup.center = CGPoint(x: self.view.bounds.m, y: self.view.bounds.midY)
//        popup.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
        
        //self.addCloseButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //self.addCloseButton()
    }
    
    func addCloseButton() {
        // make close button
        //let closeImage = UIImage(named: "CloseModal") as UIImage?
        closeButton = UIButton(type: UIButtonType.custom)
        closeButton.frame = self.frame
        closeButton.backgroundColor = .black
        //closeButton.setImage(closeImage, for: .normal)
        self.inputView?.addSubview(closeButton)
    }
}
