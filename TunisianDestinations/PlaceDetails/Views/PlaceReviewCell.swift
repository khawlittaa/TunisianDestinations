//
//  PlaceReviewCell.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/18/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit

class PlaceReviewCell: UITableViewCell {

    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userIIMAGE: UIImageView!
    @IBOutlet weak var numberDislikesLbl: UILabel!
    @IBOutlet weak var placeReviexTextView: UITextView!
    @IBOutlet weak var numberLikesLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        adjustApearance()
        adjustUITextViewHeight(arg: placeReviexTextView)
    }

    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
    func adjustApearance(){
        userIIMAGE.layer.cornerRadius = userIIMAGE.frame.size.width  / 2
        userIIMAGE.clipsToBounds = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
