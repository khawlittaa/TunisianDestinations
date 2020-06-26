//
//  CategoryPlaceDetailsViewModel.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 6/16/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import Combine

class CategoryPlaceDetailsViewModel{
    
    @Published   var category: PlaceSubCategory?{
        didSet{
            print("category is \(category?.placeSubCategoryName)")
        }
    }
  @Published   var categoryPlaces: [Place]?
    
    let searchVM = SearchViewModel()
    
    func  findPlaces(){
        
        categoryPlaces = searchVM.searchPlacesByName(name: category?.placeSubCategoryName ?? " ")
    }
    
}
