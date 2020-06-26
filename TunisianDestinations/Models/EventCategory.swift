//
//  EventCategory.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 5/20/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

enum CategoryCodingKeys: String, CodingKey {
    case id
    case name
    case imguri
    case listsubcategory
}

class EventCategory: Codable {
    var eventcategoryId: Double?
    var eventCategoryName: String?
//    var imageURI: String?
    
    init(catID : Double, catName: String) {
        eventcategoryId = catID
        eventCategoryName = catName
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CategoryCodingKeys.self)
        eventCategoryName = try container.decode(String.self, forKey: .name)
        eventcategoryId = try container.decode(Double.self, forKey: .id)
    }
}
