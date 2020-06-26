//
//  MapMarkerPlaceInfoView.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/16/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import UIKit

class MapMarkerPlaceInfoView: UIView{
    
    @IBOutlet weak var priceRangeView: UIView!
    @IBOutlet weak var placeRatingView: UIView!
    
    @IBOutlet weak var placeNameLbl: UILabel!
    @IBOutlet weak var totalReviewsLbl: UILabel!
    @IBOutlet weak var placeAdressLbl: UILabel!
    @IBOutlet weak var placeTypeLbl: UILabel!
    
    func loadData(place: Place){
        placeNameLbl.text = place.placeName
        placeAdressLbl.text = place.placeLocation?.formattedAddress
        placeTypeLbl.text = place.placeType
    }
    
     class func instanceFromNib() -> UIView {
         return UINib(nibName: "MapMarkerPlaceInfoView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
     }
}

