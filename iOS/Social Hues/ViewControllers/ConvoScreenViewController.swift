//
//  ConvoScreenViewController.swift
//  Social Hues
//
//  Created by Daniel Kim on 5/21/18.
//  Copyright © 2018 Sarah Zhou. All rights reserved.
//

import UIKit

class ConvoScreenViewController: UIViewController {
    weak var delegate: ConvoPageViewControllerDelegate?
    
    @IBAction func getStartedPressed(_ sender: UIButton) {
        moveOnToPrompt()
    }
    
    @IBAction func skipPressed(_ sender: UIButton) {
        moveOnToPrompt()
    }
    @IBAction func backPressed(_ sender: UIButton) {
        delegate?.returnToDetails()
    }
    
    func moveOnToPrompt() {
        delegate?.userDidFinishOnBoard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
