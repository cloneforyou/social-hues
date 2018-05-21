//
//  EventsTableViewController.swift
//  Social Hues
//
//  Created by Daniel Kim on 5/19/18.
//  Copyright © 2018 Sarah Zhou. All rights reserved.
//

import UIKit

protocol EventsTableViewControllerDelegate {
    func addEvent(code: String)
}

class EventsTableViewController : UITableViewController {
    var events = [String]()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
        let casted = cell as! EventCardViewCell
        
        let store = FakeEventStore()
        casted.populateVals(store.getEvent(code: events[indexPath.row]))
        return casted
    }
}

extension EventsTableViewController : EventsTableViewControllerDelegate {
    func addEvent(code: String) {
        events.append(code)
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath(row: events.count - 1, section: 0)], with: UITableViewRowAnimation.top)
        self.tableView.endUpdates()
    }
}
