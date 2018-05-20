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
    var closeButton: UIButton
    var addEventLabel: UILabel?
    
    var yOffset = CGFloat(24)
    
    var delegate: AddEventViewDelegate?
    
    init(frame: CGRect, addEventDelegate: AddEventViewDelegate) {
        self.closeButton = UIButton()
        self.delegate = addEventDelegate
        super.init(frame: frame)
        
        self.backgroundColor = .white
        layer.cornerRadius = 13
        layer.masksToBounds = true
        
        addCloseButton()
        self.addEventLabel = makeAddEventLabel()
        self.addSubview(self.addEventLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.closeButton = UIButton()
        super.init(coder: aDecoder)
    }
    
    // MARK: Nested Views
    
    private func makeAddEventLabel() -> UILabel {
        let w = CGFloat(220)
        let h = CGFloat(22)
        let newLabel = UILabel(frame: CGRect(x: self.bounds.midX - 110, y: self.bounds.minY + yOffset, width: w, height: h))
        newLabel.text = "Add Event"
        newLabel.font = UIFont(name: "CircularStd-Bold", size: 15)
        newLabel.textAlignment = .center
        
        return newLabel
    }
    
    private func addCloseButton() {
        
        
        let closeImage = UIImage(named: "CloseModal") as UIImage?
        closeButton.setImage(closeImage, for: .normal)
        closeButton.backgroundColor = .white
        closeButton.frame = CGRect(x: self.bounds.maxX - 41, y: self.bounds.minY + yOffset, width: 17, height: 17)
        closeButton.addTarget(self, action: #selector(closePressed(sender:)), for: .touchUpInside)
        self.addSubview(closeButton)
    }
    
    @objc fileprivate func closePressed(sender: UIButton) {
        //print("asdfadslkj")
        delegate?.closeAddEventPopup()
    }
}
