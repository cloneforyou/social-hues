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
    var closeButton: UIButton?
    var addEventLabel: UILabel?
    var eventCodeField: UITextField?
    var addButton: UIButton?
    
    var yOffset = CGFloat(24)
    
    var delegate: AddEventViewDelegate?
    
    var originalY: CGFloat?
    
    init(frame: CGRect, addEventDelegate: AddEventViewDelegate) {
        self.delegate = addEventDelegate
        super.init(frame: frame)
        originalY = frame.minY
        
        self.backgroundColor = .white
        layer.cornerRadius = 13
        layer.masksToBounds = true
        
        self.closeButton = makeCloseButton()
        self.addSubview(self.closeButton!)
        
        self.addEventLabel = makeAddEventLabel()
        self.addSubview(self.addEventLabel!)
        
        self.eventCodeField = makeEventCodeField()
        self.addSubview(self.eventCodeField!)
        
        self.addButton = makeAddButton()
        self.addSubview(self.addButton!)
        
        
        // TODO: fix these things not actually moving correctly or showing keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Nested Views
    
    private func makeAddButton() -> UIButton {
        let image = UIImage(named: "add button") as UIImage?
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.frame = CGRect(x: self.bounds.midX - 75, y: self.bounds.minY + 162, width: 150, height: 45)
        button.addTarget(self, action: #selector(addPressed(sender:)), for: .touchUpInside)
        
        return button
    }
    
    private func makeEventCodeField() -> UITextField {
        let field = UITextField(frame: CGRect(x: self.bounds.minX + 33, y: self.bounds.minY + 97, width: 220, height: 22))
        field.attributedPlaceholder = NSAttributedString(string: "Event Code")
        field.font = UIFont(name: "CircularStd-Book", size: 15)
        //field.autocorrectionType = .no
        return field
    }
    
    private func makeAddEventLabel() -> UILabel {
        let w = CGFloat(220)
        let h = CGFloat(22)
        let newLabel = UILabel(frame: CGRect(x: self.bounds.midX - 110, y: self.bounds.minY + yOffset, width: w, height: h))
        newLabel.text = "Add Event"
        newLabel.font = UIFont(name: "CircularStd-Bold", size: 15)
        // TODO: validate that font is working
        newLabel.textAlignment = .center
        
        return newLabel
    }
    
    private func makeCloseButton() -> UIButton {
        let closeImage = UIImage(named: "CloseModal") as UIImage?
        let button = UIButton()
        button.setImage(closeImage, for: .normal)
        button.backgroundColor = .white
        button.frame = CGRect(x: self.bounds.maxX - 41, y: self.bounds.minY + yOffset, width: 17, height: 17)
        button.addTarget(self, action: #selector(closePressed(sender:)), for: .touchUpInside)
        return button
    }
    
    // MARK: Actions
    
    @objc fileprivate func closePressed(sender: UIButton) {
        //print("asdfadslkj")
        delegate?.closeAddEventPopup()
    }
    
    @objc fileprivate func addPressed(sender: UIButton) {
        delegate?.addEventButtonPressed(code: (self.addEventLabel?.text)!)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            guard let absY = self.superview?.convert(self.frame.origin, to: nil) else {
                return
            }
            print(absY.y + self.frame.maxY)
            print(keyboardSize.origin.y)
            if absY.y + self.frame.maxY > keyboardSize.origin.y {
                print("adjusting view height for keyboard")
                self.frame.origin.y -= absY.y + self.frame.maxY - keyboardSize.origin.y
            } else {
                print("for some reason did not adjust height")
            }
        } else {
            print("wasn't able to get past this check")
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.frame.origin.y = originalY!
    }
}
