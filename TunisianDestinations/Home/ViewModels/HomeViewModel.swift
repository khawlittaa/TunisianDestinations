//
//  HomeVM.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/23/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import Combine

class HomeViewModel{
    
   @Published  var categories: [PlaceCategory]?
    // set categories from API
    
       var  task :  AnyCancellable?  =  nil
         
         private(set) lazy var onAppear: () -> Void = { [weak self] in
              self?.getCategories()
            }
         
           func getCategories() {
                 self.task = ApiPlacesClient.getPlacesCategories()
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
                          self.categories = data
                  })
              }
}
