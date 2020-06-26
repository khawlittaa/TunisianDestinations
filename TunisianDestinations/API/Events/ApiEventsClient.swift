//
//  ApiEventsClient.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 6/11/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//


import Alamofire
import Combine

class ApiEventsClient {
   
    static func getEvents() -> Future<[Event], Error>{
        return NetworkPublisher.publish(ApiEventsRouter.getAllEvents)
     }
    
    static func getEventCategories() -> Future<[EventCategory], Error>{
       return NetworkPublisher.publish(ApiEventCategoriesRouter.getEventCategories)
    }
}
