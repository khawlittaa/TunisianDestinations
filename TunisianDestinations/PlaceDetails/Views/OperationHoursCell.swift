//
//  operationHoursCell.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/3/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit

class OperationHoursCell: UITableViewCell {

    @IBOutlet weak var weekdayLbl: UILabel!
    
    var item: String? {
         didSet {
            // cast the ProfileViewModelItem to appropriate item type
          guard let item = item
         //   as? PlaceViewModelOperationhoursItem
            else {
              return
            }
            //set UI elements
            weekdayLbl.text = item
         //workingHoursLbl.text = 
         }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
