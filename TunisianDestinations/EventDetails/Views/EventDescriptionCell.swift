//
//  EventDescriptionCell.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 5/27/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit

class EventDescriptionCell: UITableViewCell {
    @IBOutlet weak var eventDescTxtView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        adjustUITextViewHeight(arg: eventDescTxtView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func adjustUITextViewHeight(arg : UITextView)
       {
           arg.translatesAutoresizingMaskIntoConstraints = true
           arg.sizeToFit()
           arg.isScrollEnabled = false
       }
    
}
