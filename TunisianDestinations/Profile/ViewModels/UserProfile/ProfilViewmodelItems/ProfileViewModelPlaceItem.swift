//
//  ProfileViewModelPlaceOreventItem.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/16/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

class ProfileViewModelPlaceItem: CustomViewModelItem{
    var type: ProfileViewModelItemType {
        return .favoritePlaces
    }
    
    var sectionTitle: String {
        return "Favorite places"
    }

    var rowCount: Int {
       return favoritePlaces.count
    }
    
    var favoritePlaces: [Place]
    
    init(favoritePlaces: [Place]) {
        self.favoritePlaces = favoritePlaces
    }
}
