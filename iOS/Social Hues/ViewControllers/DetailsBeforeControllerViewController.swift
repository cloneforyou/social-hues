//
//  DetailsBeforeControllerViewController.swift
//  Social Hues
//
//  Created by Daniel Kim on 5/20/18.
//  Copyright © 2018 Sarah Zhou. All rights reserved.
//

import UIKit

class DetailsBeforeControllerViewController: UIViewController {
    weak var delegate: EventsTableViewControllerDelegate?

    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = false
        delegate?.detailsWasDismissed()
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
