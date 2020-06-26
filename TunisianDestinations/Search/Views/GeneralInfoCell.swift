//
//  generalInfoCell.swift
//  Tounsi
//
//  Created by khaoula hafsia on 2/19/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit

class GeneralInfoCell: UITableViewCell {

    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeNameLbl: UILabel!
    @IBOutlet weak var placeAddressLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(place: Place)
    {
        placeNameLbl.text = place.placeName
        placeAddressLbl.text = place.placeLocation?.formattedAddress
    }
    
}
