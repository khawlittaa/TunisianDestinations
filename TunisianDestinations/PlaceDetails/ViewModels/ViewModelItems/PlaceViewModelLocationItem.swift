//
//  PlaceViewModelLocationItem.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/2/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import GoogleMaps

class PlaceViewModelLocationItem : PlaceViewModelItem {
    
    var type: PlaceViewModelType{
        return .location
    }
    
    var sectionTitle: String {
        return ""
    }
    
    var address: String
 //  var coordinate: CLLocationCoordinate2D
    
    init(address: String)
    //,coordinate: CLLocationCoordinate2D
    {
        self.address = address
       // self.coordinate = coordinate
    }
    
    
}
