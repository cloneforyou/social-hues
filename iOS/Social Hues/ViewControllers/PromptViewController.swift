//
//  PromptViewController.swift
//  Social Hues
//
//  Created by Daniel Kim on 5/21/18.
//  Copyright © 2018 Sarah Zhou. All rights reserved.
//

import UIKit

class PromptViewController: UIViewController {
    @IBOutlet weak var scannedLabel: UILabel!
    @IBOutlet weak var qrBoundary: UIImageView!
    @IBOutlet weak var prompt: UILabel!
    @IBOutlet weak var hold: UILabel!
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        //self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func enterQRMode(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            self.scannedLabel.isHidden = false
            self.qrBoundary.isHidden = false
            self.prompt.isHidden = true
            self.hold.isHidden = true
        } else if sender.state == .ended {
            self.scannedLabel.isHidden = true
            self.qrBoundary.isHidden = true
            self.prompt.isHidden = false
            self.hold.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.scannedLabel.isHidden = true
        self.qrBoundary.isHidden = true
        self.prompt.isHidden = false
        self.hold.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

}
