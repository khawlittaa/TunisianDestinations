//
//  EventGeneralInfoCell.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 5/27/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit
import Cosmos

class EventGeneralInfoCell: UITableViewCell {
    @IBOutlet weak var eventRatingView: CosmosView!
    
    @IBOutlet weak var eventNameLbl: UILabel!
    @IBOutlet weak var eventCategoryLbl: UILabel!
    @IBOutlet weak var numberReviewsLbl: UILabel!
    @IBOutlet weak var numbrePlacesLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
