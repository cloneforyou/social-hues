//
//  DetailsBeforeControllerViewController.swift
//  Social Hues
//
//  Created by Daniel Kim on 5/20/18.
//  Copyright © 2018 Sarah Zhou. All rights reserved.
//

import UIKit

protocol DetailsBeforeDelegate: class {
    func startPrompts()
}

class DetailsBeforeControllerViewController: UIViewController {
    weak var delegate: EventsTableViewControllerDelegate?
    var event: Event?
    var data = InMemData.getData()
    
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventTimeAndLoc: UILabel!
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = false
        delegate?.detailsWasDismissed()
    }
    
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        print("start button called")
        guard let code = event?.code, let icebreaker = data.icebreakers[code] else {
            print("could not find code or icebreaker")
            return
        }
        if  icebreaker.onboardComplete {
            startPrompts()
        } else {
            let convo = UIStoryboard(name: "ConvoOnboard", bundle: nil).instantiateInitialViewController() as! ConvoPageViewController
            convo.detailsDelegate = self
            self.present(convo, animated: true, completion: nil)
            print("presented")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.month.text = self.event?.monthString
        self.day.text = self.event?.dayString
        self.eventName.text = self.event?.title
        self.eventTimeAndLoc.text = self.event?.detailsString
        
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

extension DetailsBeforeControllerViewController: DetailsBeforeDelegate {
    func startPrompts() {
        guard let code = event?.code, let icebreaker = data.icebreakers[code] else {
            print("could not find code or icebreaker")
            return
        }
        icebreaker.onboardComplete = true
        let prompts = UIStoryboard(name: "Prompt", bundle: nil).instantiateInitialViewController() as! PromptViewController
        prompts.event = event
        prompts.addDelegateToIcebreaker()
        self.present(prompts, animated: true, completion: nil)
        //self.navigationController?.pushViewController(prompts!, animated: true)
    }
}
