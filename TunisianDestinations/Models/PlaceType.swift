//
//  PlaceType.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/25/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

class PlaceType: NSObject{
    
    var placetypeImgUrl: String
    var  placetypeName: String
    
    init(placetypeImgUrl: String, placetypeName: String) {
        self.placetypeImgUrl = placetypeImgUrl
        self.placetypeName = placetypeName
    }
}
