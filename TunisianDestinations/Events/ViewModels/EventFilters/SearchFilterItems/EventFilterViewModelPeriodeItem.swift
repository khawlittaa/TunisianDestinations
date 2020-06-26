//
//  EventFilterViewModelStartDatetem.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 5/14/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation
class EventFilterViewModelPeriodeItem: EventFilterTypeViewModelItem {
    
    var isSelected: Bool = false
    
    var type: EventFilterType{
        return .Periode
    }
    
    var FilterTitle: String{
        return "Periode"
    }
    
    var startDate: String?
    var endDate: String?
}
