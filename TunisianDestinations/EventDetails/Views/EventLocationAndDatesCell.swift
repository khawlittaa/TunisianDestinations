//
//  EventLocationCell.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 5/14/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit
import MapKit

class EventLocationAndDatesCell: UITableViewCell {
    @IBOutlet weak var eventlocationAdressLbl: UILabel!
    @IBOutlet weak var eventDatesLbl: UILabel!
    
    @IBOutlet weak var locationMapView: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
