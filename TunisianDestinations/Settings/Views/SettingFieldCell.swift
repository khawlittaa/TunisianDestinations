//
//  SettingFieldCell.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 6/2/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit

class SettingFieldCell: UITableViewCell {
    
    @IBOutlet weak var settingItemName: UILabel!
    @IBOutlet weak var settingItemValue: UILabel!
    
    var item: SettingsViewModelItem? {
        
        didSet {
            // cast the ProfileViewModelItem to appropriate item type
            guard let item = item as? EditFieldSettingViewModelItem  else {
                return
            }
            //set UI elements
            settingItemName.text = item.attribute.infoKey
            settingItemValue.text = item.attribute.infovalue
            
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
