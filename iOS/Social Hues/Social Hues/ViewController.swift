//
//  ViewController.swift
//  Social Hues
//
//  Created by Sarah Zhou on 5/14/18.
//  Copyright © 2018 Sarah Zhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: Properties

    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var colorCode: UITextField!
    @IBOutlet var background: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Converts user input into #HEXNUMBER format, only if user has generated input, and sets the background to be
    @IBAction func nextButton(_ sender: UIButton) {
        if (colorCode.hasText) {
            let userCode = colorCode.text!;
            if !(userCode.contains("#")) {
                colorCode.text = ("#" + colorCode.text!);
            }
            let color = hexStringToUIColor(hex:colorCode.text!);
            colorLabel.text = "Here Is Your Color";
            self.view.backgroundColor = color;
            
        }
        
        
    }
    
    // Converts hex to Swift UI color
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    

}

