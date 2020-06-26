//
//  Event.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 5/20/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

enum EventCodingKeys: String, CodingKey {
    case id
    case title
    case description
    case endDate
    case endTime
    case eventcategory
    case files
    case nplaces
    case phone
    case place
    case startDate
    case startTime
    case user
}

class Event: NSObject,Codable,Identifiable{
    var eventId: String?
    var eventTitle: String?
    var eventDescription: String?
    var phone: String?
    var numberPlaces: String?
    var startDate: String?
    var endDate: String?
    var startTime: String?
    var endTime: String?
    var eventCategory: EventCategory?
    var eventCreator: User?
    var pictures: [String]?
    
    override init() {
        self.eventId = "23455"
        self.eventTitle = "GYDC"
        self.eventDescription = " the bisggest Event for IT and tech in Tunisia"
        self.phone = "34567890"
        self.numberPlaces = "345"
        self.startDate = "2020-09-09"
        self.endDate = "2020-09-10"
        self.startTime = "12:00"
        self.endTime = "12:00"
        pictures = [String]()
        pictures?.append("https://i2-prod.scunthorpetelegraph.co.uk/incoming/article1116821.ece/ALTERNATES/s615/Musicfestivalgeneric.jpg")
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: EventCodingKeys.self)
        eventId = try container.decode(String?.self, forKey: .id)
        eventDescription = try container.decode(String?.self, forKey: .description)
//        eventTitle = try container.decode(String?.self, forKey: .title)
//        phone = try container.decode(String?.self, forKey: .phone)
//        numberPlaces = try container.decode(String?.self, forKey: .nplaces)
//        startDate = try container.decode(String?.self, forKey: .startDate)
//        startTime = try container.decode(String?.self, forKey: .startTime)
//        endDate = try container.decode(String?.self, forKey: .endDate)
//        endTime = try container.decode(String?.self, forKey: .endTime)
//        pictures = try container.decode([String]?.self, forKey: .files)
//        eventCategory = try container.decode(EventCategory?.self, forKey: .eventcategory)
//        eventCreator = try  container.decode(User?.self, forKey: .user)
        
    }
}
