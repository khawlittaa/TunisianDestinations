//
//  PlaceViewModelItem.swift
//  TunisianDestinations
//
//  Created by khaoula hafsia on 3/2/20.
//  Copyright © 2020 khaoula hafsia. All rights reserved.
//

import Foundation

protocol  PlaceViewModelItem {
    var type: PlaceViewModelType { get }
    var rowCount: Int { get }
    var sectionTitle: String  { get }
}


// default value of our rowCountAttribute

extension PlaceViewModelItem {
    var rowCount: Int {
        return 1
    }
}
