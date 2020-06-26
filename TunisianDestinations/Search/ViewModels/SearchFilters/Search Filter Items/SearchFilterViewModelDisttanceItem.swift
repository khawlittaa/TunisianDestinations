//
//  SearchFilterViewModelDisttanceItem.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/27/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

class SearchFilterViewModelDisttanceItem: SearchFilterTypeViewModelItem {
    var filterChoices: [String]{
        return ["500","1000","3000","5000"]
        }
    
    var type: SearchFilterType{
        return .distance
    }
    
    var FilterTitle: String{
        return "Places Near By"
    }
}
