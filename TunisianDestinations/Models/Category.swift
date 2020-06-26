//
//  Category.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/25/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

class Category: NSObject {
    var  categoryName: String
    var types: [PlaceType]
    
    init(categoryName: String, types:[PlaceType]) {
        self.categoryName = categoryName
        self.types = types
    }
}
