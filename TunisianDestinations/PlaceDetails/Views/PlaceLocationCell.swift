//
//  placeLocationCell.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 2/28/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit

class PlaceLocationCell: UITableViewCell {

    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var directionsBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var item: PlaceViewModelItem? {
        
         didSet {
            // cast the ProfileViewModelItem to appropriate item type
            guard let item = item as? PlaceViewModelLocationItem  else {
               return
            }
            //set UI elements
            addressLbl.text = item.address
         }
    }
    
}
