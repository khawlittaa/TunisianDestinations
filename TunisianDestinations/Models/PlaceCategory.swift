//
//  PlaceCategory.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 6/13/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

class PlaceCategory: Codable {

    var placeCategoryId: Double?
    var placeCategoryName: String?
    var subCategories: [PlaceSubCategory] = []
    
    required init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: CategoryCodingKeys.self)
          placeCategoryName = try container.decode(String.self, forKey: .name)
          placeCategoryId = try container.decode(Double.self, forKey: .id)
        subCategories = try container.decode([PlaceSubCategory].self, forKey: .listsubcategory)
      }
}
