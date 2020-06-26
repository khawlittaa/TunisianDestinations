//
//  EventFiltersViewModel.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 5/14/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import Combine
import UIKit


class EventFiltersViewModel: NSObject{
    
   @Published var items = [EventFilterTypeViewModelItem]()
    let EventVM = EventViewModel()

    
    override init() {
        super.init()
        let categoryItem = EventFilterViewModelCategoryItem()
        categoryItem.onAppear()
        items.append(categoryItem)
        let periode = EventFilterViewModelPeriodeItem()
        items.append(periode)
    }
    
    
       func searchEventsByCategoryAndDates(categoryId: Double, stratDate: String, endDate: String, events: [Event]?) -> [Event]?{
           // later call API to filter this is just a test
//             let events = events?.filter({(event: Event) -> Bool in
//             return event.eventCategory?.eventcategoryId == categoryId
//                 })
                 return [Event]()
                 
             }

    func filterbyCategory(categoryName: String, events: [Event]?) -> [Event]?{
      // later call API to filter this is just a test
//        let events = events?.filter({(event: Event) -> Bool in
//        return event.eventCategory?.eventCategoryName == categoryName
//            })
            return [Event]()
    }
    
    func filteerByPeriode(stratDate: String, endDate: String, events: [Event]?) -> [Event]?{
        // later call API to filter this is just a test
//        let events = events?.filter({(event: Event) -> Bool in
//            return event.eventDescription!.count > 30
//            })
            return [Event]()
    }
    
}

extension EventFiltersViewModel: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventFilterCell", for: indexPath) as! EventFilterCell
        cell.item = items[indexPath.row]
        return cell
    }
}
