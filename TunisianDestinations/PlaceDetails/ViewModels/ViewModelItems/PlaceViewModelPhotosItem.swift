//
//  PlaceViewModelPhotosItem.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/10/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

class PlaceViewModelPhotosItem: PlaceViewModelItem{
    
    var type: PlaceViewModelType{
        return .photo
    }
    
    var sectionTitle: String{
        return ""
    }
    
    var images: [String]
    
    init(images:[String]) {
        self.images = images
    }
    
    
}
