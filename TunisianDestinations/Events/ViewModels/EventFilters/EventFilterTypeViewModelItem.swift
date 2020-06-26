
//
//  EventFilterTypeViewModelItem.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 5/14/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

protocol EventFilterTypeViewModelItem {
    var type: EventFilterType { get }
    var FilterTitle: String  { get }
    var filterChoices: [EventCategory] { get }
    var isSelected: Bool { get  set }
}

// deafault value of filter choice
extension EventFilterTypeViewModelItem {
    var  filterChoices: [EventCategory]{
        return [EventCategory]()
    }
}
