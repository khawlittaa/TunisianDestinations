//
//  SearchFilterViewModelOpenNowItem.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/27/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

class SearchFilterViewModelOpenNowItem: SearchFilterTypeViewModelItem {
    var type: SearchFilterType{
        return .openNow
    }
    
    var FilterTitle: String{
            return "Open Now"
    }
    
}
