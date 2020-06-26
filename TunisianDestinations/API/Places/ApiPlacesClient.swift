//
//  ApiPlacesClient.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 6/13/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Alamofire
import Combine

class ApiPlacesClient {
    
    
    static func getPlacesSubCategories() -> Future<[PlaceSubCategory], Error>{
        return NetworkPublisher.publish(ApiPlaceSunCategoriesRouter.getPlaceSubCategories)
    }
    
    static func getPlacesCategories() -> Future<[PlaceCategory], Error>{
        return NetworkPublisher.publish(ApiPlaceCategoriesRouter.getPlaceCategories)
    }
//    addFavorite(adress: String,googleplaceID: String ,userID: String ,lat: String ,long: String ,placeName: String)
    
    static func  addPlaceToFavorite(adress: String,googleplaceID: String ,userID: Int ,lat: Double ,long: Double ,placeName: String) -> Future<[APIResponse], Error>{
        return NetworkPublisher.publish(PlaceApiResponceRouter.addFavorite(adress: adress, googleplaceID: googleplaceID, userID: userID, lat: lat, long: long, placeName: placeName))
    }
}
