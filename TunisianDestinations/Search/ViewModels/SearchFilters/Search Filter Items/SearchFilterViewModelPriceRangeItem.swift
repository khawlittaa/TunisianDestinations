//
//  SearchFilterViewModelPriceRangeItem.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/27/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

class SearchFilterViewModelPriceRangeItem: SearchFilterTypeViewModelItem {
    var type: SearchFilterType{
        return .pricerange
    }
    
    var FilterTitle: String{
        return "Price Range "
    }
    
    var filterChoices: [String]{
           return ["$","$$","$$$","$$$$"]
           }
}
