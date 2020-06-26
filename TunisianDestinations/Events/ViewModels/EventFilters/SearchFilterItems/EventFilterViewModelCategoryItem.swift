//
//  EventFilterViewModelCategoryItem.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 5/14/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import Combine

class EventFilterViewModelCategoryItem: EventFilterTypeViewModelItem {
    
    private var _isSelected: Bool = false
    var isSelected: Bool  {
        get {
            print("getting the value here")
            // here return itself property
            return  _isSelected
        }
        set {
            _isSelected = newValue
        }
    }
    
    
    var type: EventFilterType{
        return .Category
    }
    
    var FilterTitle: String{
        return "Category"
    }
    // get from API 
    var filterChoices: [EventCategory] = []
    
    var  task :  AnyCancellable?  =  nil
    
    private(set) lazy var onAppear: () -> Void = { [weak self] in
         self?.getCategories()
       }
    
      func getCategories() {
            self.task = ApiEventsClient.getEventCategories()
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
