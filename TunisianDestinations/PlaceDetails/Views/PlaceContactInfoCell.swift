//
//  PlaceGeneralInfoCell.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 2/26/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit

class PlaceContactInfoCell: UITableViewCell {
    
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var websiteLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var item: PlaceViewModelItem? {
        didSet {
            // cast the ProfileViewModelItem to appropriate item type
            guard let item = item as? PlaceViewModelContactInfoItem  else {
                return
            }
            //set UI elements
            websiteLbl.text = item.website
            phoneLbl.text = item.phone
        }
        
    }
    @IBAction func callBtnClicked(_ sender: Any) {
        let phonenumber = phoneLbl.text
        phonenumber?.makeACall()
    }
    
}

