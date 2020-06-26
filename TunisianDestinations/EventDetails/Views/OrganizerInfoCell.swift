//
//  OrganizerInfoCell.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 5/27/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit

class OrganizerInfoCell: UITableViewCell {
    @IBOutlet weak var organizerImg: UIImageView!
    @IBOutlet weak var organizerNameLbl: UILabel!
    @IBOutlet weak var callOrganizerBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        adjustApearance()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
     func adjustApearance(){
         organizerImg.layer.cornerRadius = organizerImg.frame.size.width  / 2
         organizerImg.clipsToBounds = true
     }
    @IBAction func callOrganizerBtnPressed(_ sender: Any) {
        let phoneNum = "23123456"
        phoneNum.makeACall()
    }
    
}
