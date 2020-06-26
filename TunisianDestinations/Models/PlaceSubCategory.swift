//
//  PlaceSubCtegory.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 6/13/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

class PlaceSubCategory: Codable {
    
        var placeSubCategoryId: Double?
        var placeSubCategoryName: String?
        var placeSubCategoryImageURI: String?
    
    init(catID : Double, catName: String) {
           placeSubCategoryId = catID
           placeSubCategoryName = catName
       }
    
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CategoryCodingKeys.self)
            placeSubCategoryName = try container.decode(String.self, forKey: .name)
            placeSubCategoryId = try container.decode(Double.self, forKey: .id)
            placeSubCategoryImageURI = try container.decode(String.self, forKey: .imguri)
        }
}
