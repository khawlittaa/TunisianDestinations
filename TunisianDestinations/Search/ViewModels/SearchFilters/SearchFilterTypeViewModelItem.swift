//
//  FilterTypeViewModelItem.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/27/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

protocol SearchFilterTypeViewModelItem {
    var type: SearchFilterType { get }
    var FilterTitle: String  { get }
    var filterChoices: [PlaceSubCategory] { get }
}

// deafault value of filter choice 
extension SearchFilterTypeViewModelItem {
    var  filterChoices: [PlaceSubCategory]{
        return [PlaceSubCategory]()
    }
}
