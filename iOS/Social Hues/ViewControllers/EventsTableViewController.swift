//
//  EventsTableViewController.swift
//  Social Hues
//
//  Created by Daniel Kim on 5/19/18.
//  Copyright © 2018 Sarah Zhou. All rights reserved.
//

import UIKit

protocol EventsTableViewControllerDelegate: class {
    func addEvent(code: String)
    func eventCardWasPressed(_ eventPressed: Event)
    func detailsWasDismissed()
}

class EventsTableViewController : UITableViewController {
    var events = [String]()
    var data = (UIApplication.shared.delegate as! AppDelegate).data
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        self.present(AddEventViewController(delegate:self), animated: true, completion: nil)
    }
}

extension EventsTableViewController {
    override func numberOfSections(in: UITableView) -> Int {
        // 1
        return 1
    }
    
    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 2
        return events.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventCardViewCell
        cell.delegate = self
        //let store = FakeEventStore()
        cell.populateVals(LocalEventStore.eventDB[events[indexPath.row]]!)
        return cell
    }
}

extension EventsTableViewController : EventsTableViewControllerDelegate {
    func addEvent(code: String) {
        if LocalEventStore.eventDB[code] == nil {
            return
        }
        events.append(code)
        data.icebreakers[code] = Icebreaker(event: LocalEventStore.eventDB[code]!)
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath(row: events.count - 1, section: 0)], with: UITableViewRowAnimation.top)
        self.tableView.endUpdates()
    }
    
    func eventCardWasPressed(_ eventPressed: Event) {
        let details = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "DetailsBefore") as! DetailsBeforeControllerViewController
        details.event = eventPressed
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(details, animated: true)
    }
    
    func detailsWasDismissed() {
        
    }
}
