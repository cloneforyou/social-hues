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
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let cell = tableView.dequeueReusableCellWithIdentifier("carCell", forRow: indexPath) as! UITableViewCell
        
        cell.textLabel!.text = cars[indexPath.row]
        return cell
    }
}

extension EventsTableViewController : EventsTableViewControllerDelegate {
    func addEvent(code: String) {
        events.append(code)
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableViewRowAnimation.top)
        self.tableView.endUpdates()
    }
}
