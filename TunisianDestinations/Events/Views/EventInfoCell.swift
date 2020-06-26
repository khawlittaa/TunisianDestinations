//
//  EventInfoCell.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 5/14/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit

class EventInfoCell: UITableViewCell {
    @IBOutlet weak var eventNameLbl: UILabel!
    @IBOutlet weak var eventGategoryLbl: UILabel!
    @IBOutlet weak var evntLocationLbl: UILabel!
    @IBOutlet weak var eventsDatesLbl: UILabel!
    @IBOutlet weak var eventTimesLbl: UILabel!
    @IBOutlet weak var numbrePlacesLbl: UILabel!
    
    @IBOutlet weak var eventCoverImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
