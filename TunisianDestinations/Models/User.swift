//
//  Profile.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/15/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

enum UserCodingKeys: String, CodingKey {
    case dt
    case email
    case id
    case imguri
    case lastname
    case name
    case phone
    case type
    case username
    case nevents
    case nplaces
    case activityEvent
    case activityPlace
}

class User: NSObject, Codable{
    
    var firstName: String?
    var lastName: String?
    var userName: String?
    var pictureUrl: String?
    var email: String?
    var dateofBirth: String?
    var accountType: String?
    var phoneNumber: Int?
    var userID: Int?
    var favoriteplaces: [Place]?
    var numberLikedPlaces: Int?
    var numberLikedEvents: Int?
    
    override init() {
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKeys.self)
        firstName =  try container.decode(String.self, forKey: .name)
        lastName =  try container.decode(String.self, forKey: .lastname)
        userName =  try container.decode(String.self, forKey: .username)
        email =  try container.decode(String.self, forKey: .email)
        accountType =  try container.decode(String.self, forKey: .type)
        dateofBirth =  try container.decode(String.self, forKey: .dt)
        phoneNumber =  try container.decode(Int.self, forKey: .phone)
        pictureUrl =  try container.decode(String?.self, forKey: .imguri)
        userID =  try container.decode(Int.self, forKey: .id)
        numberLikedPlaces =  try container.decode(Int.self, forKey: .nplaces)
        favoriteplaces =  try container.decode([Place]?.self, forKey: .activityPlace)
    }
}
