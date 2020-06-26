//
//  EventViewModelItem.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 5/28/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

protocol EventViewModelItem {
    var type: EventViewModelType { get }
    var rowCount: Int { get }
    var sectionTitle: String  { get }
}


// default value of our rowCountAttribute

extension EventViewModelItem {
    var rowCount: Int {
        return 1
    }
}

