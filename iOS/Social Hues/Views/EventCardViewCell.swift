//
//  EventCardViewCell.swift
//  Social Hues
//
//  Created by Daniel Kim on 5/20/18.
//  Copyright © 2018 Sarah Zhou. All rights reserved.
//

import UIKit

class EventCardViewCell: UITableViewCell {

    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventDetailsLabel: UILabel!
    var event: Event?
    weak var delegate: EventsTableViewControllerDelegate?
    
    
    @IBAction func eventCardPressed(_ sender: UIButton) {
        self.delegate?.eventCardWasPressed(event!)
    }
    
    func populateVals(_ event: Event) {
        self.event = event
        monthLabel.text = event.monthString
        dayLabel.text = event.dayString
        eventTitleLabel.text = event.title
        eventDetailsLabel.text = event.detailsString
    }
    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.contentView.frame = CGRect(x: self.contentView.frame.origin.x, y: self.contentView.frame.origin.y, width: self.contentView.frame.width, height: 85)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
