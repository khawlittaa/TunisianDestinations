//
//  EventVM.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 5/14/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import Combine

class SearchEventViewModel{
    
//    @Published  var  events:[Event]?{
//          didSet{ print ("Events did set ")}
//      }
    @Published var categoryFilter = ""
    @Published var startDateFilter = ""
    @Published var endDateFilter = ""
    @Published var searchKeyword = ""
    
    @Published var events: [Event] = []
    @Published var errorCode: String = ""
    @Published var showAlert: Bool = false
    
    let validator = RegularExpressions()
    
    var  task :  AnyCancellable?  =  nil

    private(set) lazy var onAppear: () -> Void = { [weak self] in
      self?.getItems()
    }
    
    func getItems() {
        self.task = ApiEventsClient.getEvents()
//        NetworkPublisher.publish(ItemsRequest())
         .receive(on: DispatchQueue.main)
         .sink(receiveCompletion: { completion in
           switch completion {
           case .finished:
             print("成功 all events")
           case let .failure(error):
             print(error)
             self.errorCode = error.localizedDescription
             self.showAlert = true
           }
         },
               receiveValue: { data in
                self.events = data 
                 self.errorCode = ""
                 self.showAlert = false
         })
     }
    
    lazy var validatedDates = Publishers.CombineLatest($startDateFilter, $endDateFilter)
        .map {self.validator.isValidePeriode(startDate: $0,endDate: $1) }
          .eraseToAnyPublisher()
   
//    init(){
//        let event = Event()
//        displayData?.append(event)
//        displayData?.append(event)
//    }
}
