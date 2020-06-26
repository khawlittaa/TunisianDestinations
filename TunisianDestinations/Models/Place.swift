//
//  Place.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/2/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

class Place: Codable {
    
    var placeID: String?
    var placeName: String = ""
    var pictures: [String]?
    var website: String?
    var priceLevel: Int = 0
    var phoneNumber: String?
    var placeType: String?
    var openingHours: [String]?
    var placeLocation: Location?
    var rating: Float?
    var userRatingsTotal: Int?
    
    var isfavorite:Bool?
    var isOpen: Bool?
    
    init(id: String, name:String, type: String?) {
        placeID = id
        placeName = name
        placeType = type ?? ""
    }
    
    required init(from decoder: Decoder) throws {
    }
    
    func setLocation(location: Location){
        placeLocation = location
    }
    
    func setContactInfo(phone:String, website: String){
        self.phoneNumber = phone
        self.website = website
    }
    func SetOperatingHours(times: [String]){
        openingHours = times
    }
    func setrating(rating: Float,totalUsers: Int){
        self.rating = rating
        self.userRatingsTotal = totalUsers
    }
    
    func OpenNow(open: Int?)  {
        if open == 1{
            isOpen = true
        }else{
            isOpen = false
        }
    }
    
}
