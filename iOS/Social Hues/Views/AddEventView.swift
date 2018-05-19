//
//  AddEventView.swift
//  Social Hues
//
//  Created by Daniel Kim on 5/19/18.
//  Copyright © 2018 Social Hues. All rights reserved.
//

import UIKit

@IBDesignable
class AddEventView: UIView {
    var closeButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        layer.cornerRadius = 13
        layer.masksToBounds = true
        
        let closeImage = UIImage(named: "CloseModal") as UIImage?
        closeButton.setImage(closeImage, for: .normal)
        closeButton.backgroundColor = .white
        closeButton.frame = CGRect(x: self.bounds.maxX - 41, y: self.bounds.minY + 24, width: 17, height: 17)
        self.addSubview(closeButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
