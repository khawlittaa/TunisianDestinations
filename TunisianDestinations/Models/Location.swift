//
//  Location.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/2/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import GooglePlaces

class Location: Codable{
    
    var placeID: String
    var formattedAddress: String
    //Coordinate
     var longitude: CLLocationDegrees
     var lattitude: CLLocationDegrees
    
    init(id:String, adress: String, long: CLLocationDegrees, latt: CLLocationDegrees){
        placeID = id
        formattedAddress = adress
        longitude = long
        lattitude = latt
    }
    
    
}
