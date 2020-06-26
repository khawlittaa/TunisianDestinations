//
//  CombineMessageReceiver.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 4/1/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
import Combine

class CombineMessageReceiver {
    private var cancelSet: Set<AnyCancellable> = []

    init(_ publisher: AnyPublisher<String?, Never>) {
        publisher.compactMap{$0} .sink() {
                self.handleNotification($0)
            }
            .store(in: &cancelSet)
    }

    func handleNotification(_ message: String) {
        print(" filter by category \(message)")
        let searchVC = SearchVC()
        let placesToFilter = searchVC.searchVM.searchResultPlaces
        searchVC.searchVM.searchResultPlaces =  searchVC.searchFilterVM.filterbyCategory(categoryName: message, places: placesToFilter)
     //    searchVC.searchVM.searchResultPlaces =   searchFilterVM.filterbyCategory(categoryName: message, places:placesToFilter)
 }
}
