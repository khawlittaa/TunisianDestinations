//
//  placeBasicInfoCell.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 2/28/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import UIKit

class PlaceBasicInfoCell: UITableViewCell {
    
    @IBOutlet weak var placeNameLbl: UILabel!
    @IBOutlet weak var NumReviewsLbl: UILabel!
    @IBOutlet weak var placeTypeLbl: UILabel!
    
    @IBOutlet weak var favoriteBtn: UIButton!
    //@IBOutlet weak var placeRating: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
        var item: PlaceViewModelItem? {
             didSet {
                // cast the ProfileViewModelItem to appropriate item type
                guard let item = item as? PlaceViewModelBasicInfoItem  else {
                   return
                }
                //set UI elements
                placeNameLbl.text = item.name
                placeTypeLbl.text = item.placeType
                NumReviewsLbl.text = "\(item.userRatingTotal) Reviews "
                setBgImage(fav: item.isFavorite)
             }
        
    }
    
    func setBgImage(fav: Bool){
        if fav {
            favoriteBtn.setImage(UIImage(named: "love"), for: .normal)
            // add place to favorite list
        }else{
            favoriteBtn.setImage(UIImage(named: "unlove"), for: .normal)
            // remove place from favorite list 
        }
    }
    
    @IBAction func favoritrBtnClicked(_ sender: Any) {
        
        guard let item = item as? PlaceViewModelBasicInfoItem  else {
           return
        }
        item.isFavorite = !item.isFavorite
        setBgImage(fav: item.isFavorite)
    }
    
}
