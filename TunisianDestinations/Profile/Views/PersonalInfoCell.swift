//
//  PersonalInfoCell.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/15/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit

class PersonalInfoCell: UITableViewCell {
    
    @IBOutlet weak var userInformationKeyLbl: UILabel!
    @IBOutlet weak var userInformationValueLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var item: ProfileInformation? {
        didSet {
            guard let item = item else {
                return
            }
            userInformationKeyLbl.text = item.infoKey
            userInformationValueLbl?.text = item.infovalue
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
