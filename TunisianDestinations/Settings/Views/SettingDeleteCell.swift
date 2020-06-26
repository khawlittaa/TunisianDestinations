//
//  SettingDeleteCell.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 6/3/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit

class SettingDeleteCell: UITableViewCell {
    @IBOutlet weak var deleteFieldLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLblLayout()
    }
    var item: SettingsViewModelItem? {
        
        didSet {
            // cast the ProfileViewModelItem to appropriate item type
            guard let item = item as? DeleteSettingViewModelItem  else {
                return
            }
            //set UI elements
            deleteFieldLbl.text = item.settingMessage
            if item.isPassword {
                changePassword()
            }
            
        }
    }
    
    func setLblLayout(){
        deleteFieldLbl.layer.cornerRadius = 10
        deleteFieldLbl.layer.masksToBounds = true
    }
    
    func changePassword(){
        deleteFieldLbl.backgroundColor = UIColor(named: "lightBlue")
        deleteFieldLbl.layer.cornerRadius = 10
        deleteFieldLbl.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
