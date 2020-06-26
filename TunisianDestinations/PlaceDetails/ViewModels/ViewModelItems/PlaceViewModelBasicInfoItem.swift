//
//  PlaceViewModelBasicInfoItem.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/2/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

class PlaceViewModelBasicInfoItem: PlaceViewModelItem{
    
    var type: PlaceViewModelType {
        return .basicInfo
    }
    
    var sectionTitle: String{
        return ""
    }
    
    var name: String
    var placeType:String
    var placeRating:Double
    var userRatingTotal: Int
    var isFavorite: Bool = false
    
    init(placeName:String, placeType:String, placeRating:Double, userRatingTotal: Int) {
        self.name = placeName
        self.placeType = placeType
        self.placeRating = placeRating
        self.userRatingTotal =  userRatingTotal
    }
}
    

