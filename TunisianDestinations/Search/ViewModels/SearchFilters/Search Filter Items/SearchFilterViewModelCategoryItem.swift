//
//  SearchFilterViewModelCategoryItem.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/27/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import Combine

class SearchFilterViewModelCategoryItem: SearchFilterTypeViewModelItem {
    var type: SearchFilterType{
        return .category
    }
    
    var FilterTitle: String{
        return "Category"
    }
    var filterChoices: [PlaceSubCategory] = []
    
    var  task :  AnyCancellable?  =  nil
      
      private(set) lazy var onAppear: () -> Void = { [weak self] in
           self?.getSubCategories()
         }
      
        func getSubCategories() {
              self.task = ApiPlacesClient.getPlacesSubCategories()
               .receive(on: DispatchQueue.main)
               .sink(receiveCompletion: { completion in
                 switch completion {
                 case .finished:
                   print("成功")
                 case let .failure(error):
                  print(error.localizedDescription)
                 }
               },
                     receiveValue: { data in
                       self.filterChoices = data
               })
           }
}
