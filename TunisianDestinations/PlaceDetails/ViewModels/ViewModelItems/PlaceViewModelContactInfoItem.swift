//
//  PlaceViewModelContactInfoItem.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/2/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
class PlaceViewModelContactInfoItem: PlaceViewModelItem{
    
    var type: PlaceViewModelType {
        return .contactInfo
    }
    
    var sectionTitle: String {
        return ""
    }
    
    var phone:String
    var website:String
    
    init(phone:String,website:String) {
        self.phone = phone
        self.website = website
    }
    
}

