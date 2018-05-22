//
//  SignUpViewController.swift
//  Social Hues
//
//  Created by Daniel Kim on 5/18/18.
//  Copyright © 2018 Social Hues. All rights reserved.
//

import UIKit

class SignUpViewController : UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var eventCode: UITextField!
    
    
    @IBAction func myTextFieldTouchDown(_ sender: UITextField) {
        highlightSelectedTextField(textField: sender)
    }
    
    // When editing ends...
    @IBAction func myTextFieldEditingDidEnd(_ sender: UITextField) {
        let whitespace = NSCharacterSet.whitespaces
        if(nameField.text?.trimmingCharacters(in: whitespace) == ""){
            errorHighlightTextField(textField: sender)
        }
        else{
            removeErrorHighlightTextField(textField:nameField)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    
    // When focussed - show gray border
    func highlightSelectedTextField(textField: UITextField){
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
    }
    
    // Text Field is empty - show red border
    func errorHighlightTextField(textField: UITextField){
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.placeholder = "required field!"
    }
    
    // Text Field is NOT empty - show gray border with 0 border width
    func removeErrorHighlightTextField(textField: UITextField){
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 0
        textField.layer.cornerRadius = 5
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        if nameField.text == "" {
            return
        }
        if lastName.text == "" {
            return
        }
        if email.text == "" {
            return
        }
        if phone.text == "" {
            return
        }
        
        // save data in temp in mem data store
        (UIApplication.shared.delegate as! AppDelegate).data.me = Contact(first: nameField.text!, last: lastName.text!, email: email.text!, phone: phone.text!)
        
        let events = UIStoryboard(name: "Events", bundle: nil).instantiateInitialViewController()
        self.present(events!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / 2 + 20
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height / 2 + 20
            }
        }
    }

}
